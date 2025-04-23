locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${aws_eks_cluster.name.certificate_authority[0].data})}
    server: ${aws_eks_cluster.name.endpoint}
  name: kubernetes
  contexts:
  - context:
      cluster: kubernetes
      user: "${aws_eks_cluster.name.name}"
    name: "${aws_eks_cluster.name.name}"
  current-context: ${aws_eks_cluster.name.name}
kind: Config
preferences: {}
users:
- name: "${aws_eks_cluster.name.name}"
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
      - "token"
      - "-i"
      - "${aws_eks_cluster.name.name}"
        # This is the path to the AWS CLI executable. Adjust if necessary.
KUBECONFIG
}

resource "local_file" "kubeconfig" {
  content  = local.kubeconfig
  filename = "${path.module}/kubeconfig-${var.prefix}-${var.cluster_name}"
  
}