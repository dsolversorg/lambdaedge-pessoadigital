data "aws_s3_bucket" "bucket" {
  bucket = var.bucket
}

data "aws_s3_bucket" "domain_name" {
  bucket = var.bucket
}

data "aws_acm_certificate" "issued" {
  domain   = var.domain
  statuses = ["ISSUED"]
}