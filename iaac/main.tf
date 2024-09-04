terraform {
  backend "s3" {
    encrypt = true
    bucket  = "mytestbucket"
    key     = "tf-statefile/state-file.tfstate"
    region  = "us-east-1"
    profile = "test"
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "test"
}

variable "region" {
  default = "us-east-1"
}

variable "name" {
  default = "three-tier-app"
}

variable "instance_eks" {
  default = "t2.small"
}

variable "bucket" {
  default = "my-three-tier-app-bucket"
}
