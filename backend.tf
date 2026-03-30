terraform {
    backend "s3" {
        bucket         = "ssm-demo-434655687811"
        key            = "ssm-demo-state.tfstate"
        region         = "eu-central-1"
        use_lockfile   = true
    }
}