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

# cloudwatch log group for the cluster
resource "aws_cloudwatch_log_group" "log" {
  name = "/aws/eks/${var.prefix}-${var.cluster_name}-log-group"
  retention_in_days = var.retention_in_days
  tags = {
    Name = "${var.prefix}-log-group"
  }
}

# EKS cluster resource
resource "aws_eks_cluster" "name" {
  name = "${var.prefix}-${var.cluster_name}"
  role_arn = aws_iam_role.cluster_role.arn
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler" ]
  
  vpc_config {
    subnet_ids = aws_subnet.subnets[*].id
    security_group_ids = [aws_security_group.sg.id]
  }
  
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSVPCResourceController,
    aws_cloudwatch_log_group.log
  ]
  
  tags = {
    Name = "${var.prefix}-${var.cluster_name}"
  }
}