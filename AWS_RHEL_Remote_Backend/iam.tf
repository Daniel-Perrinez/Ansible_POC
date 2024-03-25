# resource "aws_iam_openid_connect_provider" "RHEL_oidc_provider" {
#   url = "https://token.actions.githubusercontent.com"
#   client_id_list = ["sts.amazonaws.com"]
#   thumbprint_list = ["${var.oidc_thumbprint}"]

#   tags = var.tags
# }

# #Currently we don't want to grant permissions for TF to create IAM roles but we can eventually restrict 
# resource "aws_iam_role" "github_actions_role" {
#   name               = "github-actions-role"
#   assume_role_policy = file("${path.module}/policies/role-trusted-entity.json")
# }

# resource "aws_iam_policy" "backend-policy" {
#   name   = "backend-policy"
#   policy = file("policies/backend-policy.json")
# }

# resource "aws_iam_role_policy_attachment" "github_actions_role_policy_attachement" {
#   role       = aws_iam_role.github_actions_role.name
#   policy_arn = "arn:aws:iam::905418106762:policy/backend-policy"
# }
