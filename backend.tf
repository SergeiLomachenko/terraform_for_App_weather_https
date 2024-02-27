terraform {
  backend "s3" {
    bucket         = "sergey-lom-bucket-29-01-2024"
    key            = "sergey/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
  }
}