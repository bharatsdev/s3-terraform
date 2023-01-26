variable "bucket_arn" {
  type = string
}

data "aws_iam_policy_document" "tf_bucket_policies_document" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    resources = [
      var.bucket_arn,
    ]
  }
}

output "policyDocument" {
  value = data.aws_iam_policy_document.tf_bucket_policies_document
}
