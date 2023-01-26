
variable "buckests" {
  type    = list(string)
  default = ["test_1", "test_2", "test_3"]
}

# Create s3 bucket
resource "aws_s3_bucket" "tf_bucket" {
  bucket = "tf-bucket-s3-test-data"
}

# Enable version on bucket 
resource "aws_s3_bucket_versioning" "tf_bucket_version" {
  bucket = aws_s3_bucket.tf_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Life cycle rules for bucket
resource "aws_s3_bucket_lifecycle_configuration" "tf_bucket_lifecycle" {
  bucket = aws_s3_bucket.tf_bucket.id
  rule {
    id     = "Delete-Non-Current-Object"
    status = "Enabled"
    noncurrent_version_expiration {
      noncurrent_days = 23362

    }
    expiration {
      days = 34
    }
  }
}

# Bucket Policies
resource "aws_s3_bucket_policy" "tf_bucket_policies" {
  bucket = aws_s3_bucket.tf_bucket.id
  policy = module.policyDoc.policyDocument.json

}

# Block public Access
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.tf_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Bucket Policies Module
module "policyDoc" {
  source     = "./policies"
  bucket_arn = aws_s3_bucket.tf_bucket.arn
}


output "bucketARN" {
 value = aws_s3_bucket.tf_bucket.arn
}

