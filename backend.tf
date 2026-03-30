terraform {
    backend "s3" {
        bucket         = "teamcity-ssm-demo"
        key            = "teamcity-ssm-demo-state.tfstate"
        region         = "eu-central-1"
        use_lockfile   = true
    }
}