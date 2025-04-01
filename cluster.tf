# ecyrity group for the cluster
# This file is part of the Terraform configuration for AWS EKS cluster setup.
resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.aws-vpc.id
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    prefix_list_ids = []
  } 
  
  tags = {
    Name = "${var.prefix}-sg"
  }
}

# IAM role for the cluster
resource "aws_iam_role" "cluster_role" {
  name = "${var.prefix}-${var.cluster_name}-role"
  assume_role_policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  POLICY
  
  tags = {
    Name = "${var.prefix}-cluster-role"
  }
  
}

#IAM policy attachment for the cluster role "controller"
resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  role       = aws_iam_role.cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# IAM policy attachment for the cluster role "controller"
resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSVPCResourceController" {
  role = aws_iam_role.cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}