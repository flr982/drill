resource "aws_s3_bucket" "b" {
  bucket = var.bucket_name

  tags = var.common_tags
}

resource "aws_s3_bucket_versioning" "b" {
  bucket = aws_s3_bucket.b.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.b.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "b" {
  bucket = aws_s3_bucket.b.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::638626797715:user/florian"
            },
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::${var.bucket_name}"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::638626797715:user/florian"
            },
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::${var.bucket_name}/*"
        }
    ]
}
POLICY
}
