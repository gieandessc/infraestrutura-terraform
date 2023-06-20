resource "aws_vpc" "main_tf" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main_subnet_1_tf" {
  vpc_id            = aws_vpc.main_tf.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "PUBLIC 1"
  }
}

resource "aws_subnet" "main_subnet_2_tf" {
  vpc_id            = aws_vpc.main_tf.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "sa-east-1b"

  tags = {
    Name = "PUBLIC 2"
  }
}