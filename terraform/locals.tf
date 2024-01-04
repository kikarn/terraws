locals {
  #Use this naming prefix for resources
  naming_prefix = "${var.naming_prefix}-${var.environment}"
  #Create a unique s3 bucket name 
  s3_bucket_name = "${lower(local.naming_prefix)}-s3-${random_integer.s3.result}"
}

#Create a random number to attach to S3 bucket name, to make a unique name
resource "random_integer" "s3" {
  min = 10000
  max = 99999
}


