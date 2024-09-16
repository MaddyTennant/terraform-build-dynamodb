variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-2"
}

variable "profile" {
  description = "AWS profile"
  type        = string
  default     = "test_user"
}

variable "ami" {
  description = "Ami"
  type        = string
  default     = "ami-08d70e59c07c61a3a"
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "little_ec2"
}