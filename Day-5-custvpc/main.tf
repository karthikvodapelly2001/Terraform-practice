#creating custom vpc
resource "aws_vpc" "custvpc" {
 cidr_block = "10.0.0.0/16"

 tags  = {
    Name="custom-Vpc"
 }
 
}

resource "aws_subnet" "cust_subnet" {
  vpc_id = aws_vpc.custvpc.id

   tags  = {
    Name="tf_subnet"
 }
 cidr_block = "10.0.0.0/24"
 availability_zone = "us-east-1a"

}

resource "aws_internet_gateway" "cust_IG" {
vpc_id = aws_vpc.custvpc.id

 tags  = {
    Name="custom-IG"
 }
 
}

resource "aws_route_table" "cust_RT" {
  vpc_id = aws_vpc.custvpc.id

  tags ={
   Name="Cust_RT"
  }
  route {
   cidr_block="0.0.0.0/0"
   gateway_id = aws_internet_gateway.cust_IG.id
  }

}

resource "aws_route_table_association" "subnet_association" {
   route_table_id = aws_route_table.cust_RT.id
 subnet_id = aws_subnet.cust_subnet.id

}


resource "aws_security_group" "cust_SG" {
  vpc_id = aws_vpc.custvpc.id
  tags = {
   Name="cust-SG"
  }

    # Inbound Rule: Allow all traffic
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"   # "-1" means all protocols
    cidr_blocks = ["0.0.0.0/0"]  # Allows traffic from anywhere
  }

  # Outbound Rule: Allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"   # "-1" means all protocols
    cidr_blocks = ["0.0.0.0/0"]  # Allows traffic to anywhere
  }
}

resource "aws_instance" "TF-instance" {

   ami ="ami-053a45fff0a704a47"
   instance_type = "t2.micro"


   tags = {
     Name="TF-Instance"
   }
   key_name = "nv-personal-KP"
   subnet_id = aws_subnet.cust_subnet.id
   vpc_security_group_ids = [ aws_security_group.cust_SG.id ]
   
  
}










output "custom_vpc" {
  value = aws_vpc.custvpc.tags.Name
  
}

output "custom_subnet" {
  value = aws_subnet.cust_subnet.tags.Name
  
}

output "custom_IG" {
  value = aws_internet_gateway.cust_IG.tags.Name
  
}
output "custom_RT" {
  value = aws_route_table.cust_RT.tags.Name
  
}