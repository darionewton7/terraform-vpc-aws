# It defines the required providers and their versions for the configuration.
terraform {
    required_version = ">=0.13.1"
    required_providers {
        aws = ">= 5.93.0"
        local = ">= 2.5.0" 
    }
}

# It also sets the AWS region to be used for the resources.
provider "aws" {
    region = "us-east-1"
}