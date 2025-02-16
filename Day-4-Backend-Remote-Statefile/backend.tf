terraform {
  backend "s3" {
    bucket         = "mybuckettmumbaii"
    key            = "terraform.tfstate"
    region = "ap-south-1"

  }
}
