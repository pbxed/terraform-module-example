terraform {
  required_version = "~> 1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "=5.0.1"
    }
  }
}

provider "aws" {
  region                   = "eu-west-2"
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "pbx"
}

module "lambda" {
  source    = "./modules/lambda"
  s3_bucket = module.s3.s3_bucket_id
  s3_key    = module.s3.s3_lambda_key_id
  env_vars  = module.env_vars.common
}

module "s3" {
  source = "./modules/s3"
}

module "env_vars" {
  source          = "./modules/env_vars"
  common_env_vars = var.common_env_vars
}






