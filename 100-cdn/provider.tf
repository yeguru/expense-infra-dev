terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }
  backend "s3"{
    bucket = "82s-yr-remote-state-dev"
    key    = "expense-dev-cdn"  #key should be unique with in the bucket and it should not be used in other repos or  tf projects
    region = "us-east-1"
    dynamodb_table = "82s-yr-remote-state-dev"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}