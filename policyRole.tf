resource "aws_iam_role" "maintenance_role" {
  name = "${var.resource_group_name[0]}-MaintenanceRole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "ssm.amazonaws.com"
      },
      "Action" : "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "maintenance_policy" {
  name        = "${var.resource_group_name[0]}-MaintenancePolicy"
  description = "Policy for maintenance tasks"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ssm:GetAutomationExecution",
          "ssm:StartAutomationExecution"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DescribeInstanceStatus",
          "ec2:StartInstances",
          "ec2:StopInstances"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "ResourceGroupList",
        "Effect" : "Allow",
        "Action" : [
          "resource-groups:ListGroups",
          "tag:GetResources"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "ResourceGroupView",
        "Effect" : "Allow",
        "Action" : [
          "resource-groups:ListGroupResources",
          "resource-groups:GetGroup",
          "resource-groups:GetTags",
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "maintenance_policy_attachment" {
  name       = "${var.resource_group_name[0]}-MaintenancePolicyAttachment"
  roles      = [aws_iam_role.maintenance_role.name]
  policy_arn = aws_iam_policy.maintenance_policy.arn
}