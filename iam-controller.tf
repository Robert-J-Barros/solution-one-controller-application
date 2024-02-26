data "aws_iam_role" "aws_load_balancer_controller"{
     name = "aws-load-balancer-controller"
}

data "aws_iam_role" "cluster" {
  name = "demo2"
}

data "aws_iam_role" "cluster_role" {
  name = data.aws_eks_cluster.cluster.role_arn
}

resource "aws_iam_policy" "assume_sts_role_policy" {
  name        = "AssumeRolePolicyForLoadBalancerController"
  description = "Policy for assuming the AWS Load Balancer Controller role"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "sts:AssumeRole"
        Resource = data.aws_iam_role.aws_load_balancer_controller.arn
      }
    ]
  })
}


data "aws_iam_role" "cluster_role" {
  name = aws_eks_cluster.cluster.role_arn
}
resource "aws_iam_role_policy_attachment" "aws_eks_sts_attach" {
  role       = data.aws_iam_role.eks-cluster.name
  policy_arn = aws_iam_policy.assume_sts_role_policy.arn
}

