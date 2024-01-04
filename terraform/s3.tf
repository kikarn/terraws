###Configuration for S3 bucket

#Create bucket for web site
resource "aws_s3_bucket" "web_bucket" {
  bucket        = local.s3_bucket_name
  force_destroy = true
}

# Upload index.html to bucket
resource "aws_s3_object" "site" {
  bucket = aws_s3_bucket.web_bucket.bucket
  key    = "/website/index.html"
  source = "./web/index.html"
}

# Upload avatar2.png to bucket
resource "aws_s3_object" "picture" {
  bucket = aws_s3_bucket.web_bucket.bucket
  key    = "/website/avatar2.png"
  source = "./web/avatar2.png"
}