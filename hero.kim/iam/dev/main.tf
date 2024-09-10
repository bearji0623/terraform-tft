module "dev_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "dev_vpc_restrict_policy"
  path        = "/"
  description = "VPC 생성을 금지하는 dev 정책"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:CreateVpc"
      ],
      "Effect": "Deny",
      "Resource": "*"
    }
  ]
}
EOF
}