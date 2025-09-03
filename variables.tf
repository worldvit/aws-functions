variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-west-2"
}

# variable "subnet_cidrs" {
#   description = "A list of CIDR blocks for the subnets"
#   type        = list(string)
#   default     = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20", "10.0.48.0/20"]
# }

# variable "subnets" {
#   description = "A map of subnet configurations, with each key being a unique name."
#   type = map(object({
#     cidr_block = string
#     az         = string
#   }))

#   default = {
#     "subnet-a-1" = {
#       cidr_block = "10.0.0.0/20"
#       az         = "us-west-2a"
#     },
#     "subnet-a-2" = {
#       cidr_block = "10.0.16.0/20"
#       az         = "us-west-2a"
#     },
#     "subnet-b-1" = {
#       cidr_block = "10.0.32.0/20"
#       az         = "us-west-2b"
#     },
#     "subnet-b-2" = {
#       cidr_block = "10.0.48.0/20"
#       az         = "us-west-2b"
#     }
#   }
# }

variable "subnets" {
  description = "A map of subnet configurations, with each key being a unique name."
  type = map(object({
    cidr_block = string
    az         = string
    is_public  = bool # Add this new attribute
  }))

  default = {
    "subnet-a-1" = {
      cidr_block = "10.0.0.0/20"
      az         = "us-west-2a"
      is_public  = true # This will be a public subnet
    },
    "subnet-a-2" = {
      cidr_block = "10.0.16.0/20"
      az         = "us-west-2a"
      is_public  = false # This will be a private subnet
    },
    "subnet-b-1" = {
      cidr_block = "10.0.32.0/20"
      az         = "us-west-2b"
      is_public  = true # This will be a public subnet
    },
    "subnet-b-2" = {
      cidr_block = "10.0.48.0/20"
      az         = "us-west-2b"
      is_public  = false # This will be a private subnet
    }
  }
}


variable "instance_types" {
  description = "A list of EC2 instance types"
  type        = list(string)
  default     = ["t3.micro", "t3.small", "t3.large"]
}

variable "ec2_ami_id" {
  description = "The AMI ID for the EC2 instance (Ubuntu 24.04 LTS for us-west-2)"
  type        = string
  default     = "ami-03aa99ddf5498ceb9"
}

variable "allowed_ports_string" {
  description = "A comma-separated list of ports to allow for ingress"
  type        = string
  default     = "80,443,22" # HTTP, HTTPS, SSH
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "db_instance_type_map" {
  description = "A map of instance types based on the environment"
  type        = map(string)
  default = {
    "dev"  = "t3.micro"
    "prod" = "t3.medium"
  }
}

# (Add this new variable to your existing variables.tf file)

variable "common_tags" {
  description = "A map of common tags to apply to all resources"
  type        = map(string)
  default = {
    "Project"     = "aws-functions"
    "ManagedBy"   = "Terraform"
    "Environment" = "dev"
  }
}