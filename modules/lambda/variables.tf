variable "s3_bucket" {
  description = "The name of the S3 bucket to store lambda build in"
  type        = string
}

variable "s3_key" {
  description = "The key of the lambda in the S3 bucket"
  type        = string
}

variable "env_vars" {
  description = "common environment variables for all lambdas"
  type        = map(string)
}