terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.47.0"
    }
  }

  required_version = ">= 1.3"
}
 # Workspaces allow users to manage different sets of infrastructure using the same configuration by isolating state files.
 # Modules, on the other hand, are a logical container for multiple resources that are used together, facilitating reusability and better organization of your code.

  # backend "s3" {
  #   bucket         = "tf-state-bucket"
  #   key            = "terraform.tfstate"
  #   region         = "eu-central-1"
  #   dynamodb_table = "tf_state_lock"
  # }

provider "aws" {
  region  = var.region
  profile = var.profile
}

resource "aws_instance" "my_vm" {
  ami           = var.ami
  instance_type = var.instance_type
  
  tags = {
    Name = var.instance_name
  }
}

resource "aws_dynamodb_table" "basic_dynamodb_table" {
  name = "DynamoDB-Terraform"
  billing_mode = "PROVISIONED"
  read_capacity = 20
  write_capacity = 20
  # hash_key: This is the partition key for the DynamoDB table. It is used to distribute data across partitions for scalability.
  hash_key = "UserId"
  # range_key: This is the sort key for the DynamoDB table. It allows for sorting of items with the same partition key.
  range_key = "Name"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "Name"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled = false
  }

  global_secondary_index {
    name = "UserTitleIndex"
    hash_key = "UserId"
    range_key = "Name"
    write_capacity = 10
    read_capacity = 10
    projection_type = "KEYS_ONLY"
    non_key_attributes = [  ]
  }

  tags = {
    Name = "dynamodb-table"
    Environment = "dev"
  }
}