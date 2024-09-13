provider "aws" {
  region  = "us-east-1"
  profile = "default"

  default_tags {
    tags = {
      Project   = "Tentativa de api com lambda"
      CreateAt  = "2024-09-13"
      ManagedBy = "Terraform"
      Owner     = "Felipe"
    }
  }
}