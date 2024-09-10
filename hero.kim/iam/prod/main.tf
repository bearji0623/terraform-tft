module "prod_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "prod_vpc_allow_policy"
  path        = "/"
  description = "VPC 생성을 허용하는 prd 정책"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:CreateVpc"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}