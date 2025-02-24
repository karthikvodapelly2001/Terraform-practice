resource "aws_vpc" "Cust-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name="cust-vpc"
  }
}

data "aws_vpc" "cust-vpc-filter" {
  filter {
    name = "tag:Name"
    values = [ "cust-vpc" ]
  }
  depends_on = [ aws_vpc.Cust-vpc ]
}

resource "aws_subnet" "cust-public-subnet" {
  vpc_id = data.aws_vpc.cust-vpc-filter.id
  availability_zone = "us-east-1b"
  cidr_block = "10.0.0.0/24"
  depends_on = [ aws_vpc.Cust-vpc ]
  tags = {
    Name="cust-public-subnet"
  }
}