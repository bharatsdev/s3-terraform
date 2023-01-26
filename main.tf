provider "aws" {
  region     = "ap-south-1"
  access_key = "XXXXX"
  secret_key = "XXXX"
}

module "s3" {
  source = "./s3"
}

output "bucketARN" {
  value = module.s3.bucketARN
}
