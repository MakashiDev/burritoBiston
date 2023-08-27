terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


variable "region" {
  type    = string
  default = "us-west-2"
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "burittobison" {
  bucket = "burittobison-christian"

  tags = {
    name = "burittobison game"
  }
}

resource "aws_s3_bucket_ownership_controls" "burittobison" {
  bucket = aws_s3_bucket.burittobison.id

  rule {
    object_ownership = "BucketOwnerPreferred"

  }
}

resource "aws_s3_bucket_public_access_block" "burittobison" {
  bucket = aws_s3_bucket.burittobison.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "burittobison" {
  depends_on = [aws_s3_bucket_ownership_controls.burittobison, aws_s3_bucket_public_access_block.burittobison]

  bucket = aws_s3_bucket.burittobison.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "burittobison" {
  bucket = aws_s3_bucket.burittobison.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}










