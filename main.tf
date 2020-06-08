provider "aws" {
  version = "~> 2.52"
  region  = "us-west-2"
}

provider "aws" {
  alias   = "us-east-1"
  version = "~> 2.52"
  region  = "us-east-1"
}

terraform {
  backend "s3" {
  }
}

