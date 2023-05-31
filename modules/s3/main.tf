resource "random_pet" "name" {
  prefix = "pbx"
  length = 3
}

resource "aws_s3_bucket" "this" {
  bucket = random_pet.name.id
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id

  acl = "private"

  depends_on = [aws_s3_bucket_ownership_controls.this]
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_object" "lambda" {
  bucket = aws_s3_bucket.this.id
  key    = "terraform-child-module-with-env-tfvars-example-1.0-SNAPSHOT.jar"
  source = "target/terraform-child-module-with-env-tfvars-example-1.0-SNAPSHOT.jar"
  etag   = filemd5("target/terraform-child-module-with-env-tfvars-example-1.0-SNAPSHOT.jar")
}