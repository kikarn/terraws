#### EC2 Instance configuration

resource "aws_instance" "testburk" {
  count                  = var.instance_count
  ami                    = "ami-0014ce3e52359afbd"
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnets[count.index].id
  vpc_security_group_ids = [aws_security_group.SG-testburk.id]
  iam_instance_profile   = aws_iam_instance_profile.testburk_profile.name
  depends_on             = [aws_iam_role_policy.allow_s3_all]
  user_data              = <<EOF
#! /bin/bash
sudo apt-get update
sudo apt install awscli -y
sudo apt-get install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
sudo rm /var/www/html/index.html
aws s3 cp s3://${aws_s3_bucket.web_bucket.id}/website/index.html /var/www/html/index.html
aws s3 cp s3://${aws_s3_bucket.web_bucket.id}/website/avatar2.png /var/www/html/avatar2.png
EOF

  tags = {
    Name = "${local.naming_prefix}-server-${count.index}"
  }
}