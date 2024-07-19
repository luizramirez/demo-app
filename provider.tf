
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

# Store the tfstate file on an S3 bucket
terraform {
  backend "s3" {
    bucket = "hoch-engineer-dev"
    key    = "state/terraform.tfstate"
    region = "us-west-2"
  }
}