module "modules-practice" {
  source = "../Day-2-modules-resource"
  ami    = "ami-085ad6ae776d8f09c"
  key    = "nv-personal-KP"
  type   = "t2.micro"
  tags = {
    Name ="DEV-server"
  }
  
}
