provider "aws" {
  region     = "ap-south-1"
}

module "s3" {
  source = "./s3"
}

output "bucketARN" {
  value = module.s3.bucketARN
}
