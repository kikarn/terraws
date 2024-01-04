### IAM profiles and security groups

# Create IAM role for instances to access S3 bucket

resource "aws_iam_role" "allow_s3" {
  name               = "${local.naming_prefix}-allow-s3"
  assume_role_policy = <<EOF
      {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Attach above role to instances
resource "aws_iam_instance_profile" "testburk_profile" {
  name = "${local.naming_prefix}-testburk_profile"
  role = aws_iam_role.allow_s3.name
}


#Create policy for S3 access and set to role created above
resource "aws_iam_role_policy" "allow_s3_all" {
  name = "${local.naming_prefix}-allow-s3-all"
  role = aws_iam_role.allow_s3.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
                "arn:aws:s3:::${local.s3_bucket_name}",
                "arn:aws:s3:::${local.s3_bucket_name}/*"
            ]
    }
  ]
}
EOF

}




#### Security Groups
# EC2 instance Testburk sec group
resource "aws_security_group" "SG-testburk" {
  name   = "SG-testburk"
  vpc_id = aws_vpc.VPC-1.id

  #Allow HTTP from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



# Loadbalancer testburk-lb sec group
resource "aws_security_group" "SG-LB" {
  name   = "SG-LB"
  vpc_id = aws_vpc.VPC-1.id

  #Allow HTTP from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}