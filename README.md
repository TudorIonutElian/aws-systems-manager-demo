# SSM Demo

Terraform project that provisions 5 EC2 instances and deploys a React web app to all of them using AWS Systems Manager (SSM). Deployment and fleet management are fully automated via GitHub Actions.

## What it does

- Launches 5 Amazon Linux 2023 EC2 instances with public IPs
- Attaches an IAM role with SSM, S3, and EC2 permissions so instances can be managed remotely
- Builds a React app and uploads the artifact to a private S3 bucket
- Deploys the React app to all instances via SSM Run Command (pulls from S3, serves with Apache)
- Provides a separate workflow to block port 80 across the entire fleet via SSM Automation

## Prerequisites

- AWS account with permissions to create EC2, IAM, SSM, S3, and security group resources
- GitHub repository secrets:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
- S3 bucket and DynamoDB table for Terraform remote state (see `backend.tf`)

## Workflows

### Deploy (`deploy.yml`)

Triggered manually from GitHub Actions. Runs end-to-end:

1. **Terraform apply** — provisions all AWS infrastructure
2. **React build** — installs dependencies and builds the app in `web/`
3. **Upload to S3** — tars `dist/` and uploads to the artifacts bucket
4. **Wait for SSM agents** — polls until all 5 instances are registered with SSM
5. **Deploy via SSM** — runs `AWS-RunShellScript` on all instances to pull the build from S3 and serve it with Apache
6. **Save repo variables** — writes `DEPLOY_BUILD_NUMBER` and `DEPLOY_SECURITY_GROUP_ID` as GitHub repo variables for use by other workflows
7. **Print URLs** — outputs the public URL for each instance

### Block Port 80 (`block-port-80.yml`)

Triggered manually from GitHub Actions. No inputs required — reads `DEPLOY_BUILD_NUMBER` and `DEPLOY_SECURITY_GROUP_ID` saved by the deploy workflow.

1. **SSM Automation** — runs the `block_port_80` document which:
   - Discovers all running fleet instances by `Environment` tag
   - Revokes the port 80 ingress rule on the security group via the AWS EC2 API

> `deploy.yml` must have run at least once before this workflow can be triggered.

## Terraform outputs

| Output | Description |
|---|---|
| `instance_ids` | IDs of all 5 EC2 instances |
| `instance_public_ips` | Public IP addresses |
| `website_urls` | `http://<ip>` URLs for each instance |
| `artifact_bucket_name` | S3 bucket used for React build artifacts |
| `security_group_id` | ID of the web security group |

## Variables

| Name | Description | Default |
|---|---|---|
| `build_number` | Build number from CI/CD pipeline (required) | — |
| `ssm_instance_count` | Number of EC2 instances | `5` |
| `ssm_instance_type` | EC2 instance type | `t2.micro` |
| `startsWith` | AMI name prefix filter | `al2023-ami` |
| `endsWith` | AMI name suffix filter | `x86_64` |
| `architecture` | AMI architecture | `x86_64` |

## File structure

```
.
├── main.tf                 # AWS provider configuration
├── backend.tf              # S3 remote state backend
├── variables.tf            # Input variables
├── outputs.tf              # Terraform outputs
├── ami-filter.tf           # Latest Amazon Linux 2023 AMI lookup
├── ec2.tf                  # 5 EC2 instances
├── iam.tf                  # IAM role, instance profile, and policies
├── key-pair.tf             # TLS key pair
├── security-group.tf       # Security group (port 80 inbound)
├── s3-artifacts.tf         # Private S3 bucket for React build artifacts
├── apache-document.tf      # SSM document resources
├── documents/
│   ├── apache-server.yaml  # SSM Command document — installs Apache, serves React app
│   └── block-port-80.yaml  # SSM Automation document — revokes port 80 on the fleet SG
├── web/                    # React application (Vite)
│   ├── index.html
│   ├── vite.config.js
│   ├── package.json
│   └── src/
│       ├── main.jsx
│       ├── App.jsx
│       └── index.css
└── .github/
    └── workflows/
        ├── deploy.yml          # Provisions infra, builds and deploys the React app
        └── block-port-80.yml   # Blocks port 80 across the fleet via SSM Automation
```
