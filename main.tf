resource "aws_s3_bucket" "bishal_bucket" {
  bucket = "bishal-zogi-example-bucket"

  tags = {
    Name        = "bishal zogi"
    Environment = "Dev"
  }
}

resource "aws_iam_user" "bishal_user" {
  name = "bishal_user"
  
}

resource "aws_iam_user_policy" "example_user_policy" {
  name = "example_user_policy"
  user = aws_iam_user.bishal_user.name  
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:*"
        ],
        "Resource": [
          "arn:aws:s3:::bishal-bucket",
          "arn:aws:s3:::bishal-bucket/*"
        ],
      },
    ]
  })
  
}

resource "aws_security_group" "bishal_security_group" {
  name = "bishal_security_group"
  description = "Allow inbound connections on ports 80 and 443"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  
}
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bishal_instance" {
  count = 2
  ami = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.bishal_security_group.name]
  tags = {
    Name = "bishal_instance-${count.index + 1}"
  }
  
}
