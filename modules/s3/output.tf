output "s3_bucket_id" {
  value = aws_s3_bucket.this.id
}

output "s3_lambda_key_id" {
  value = aws_s3_object.lambda.key
}