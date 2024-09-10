module "prod_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "94102108-test"
  path        = "/"
  description = "Base restrictions for resources"

  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "DenyOuterRegion",
            "Effect": "Deny",
            "NotAction": [
                "iam:*",
                "access-analyzer:*",
                "route53:*",
                "route53domains:*",
                "aws-marketplace:*",
                "health:*",
                "chatbot:*",
                "waf:*",
                "wafv2:*",
                "waf-regional:*",
                "cloudfront:*",
                "cloudfront-keyvaluestore:*",
                "cloudwatch:*"
            ],
            "Resource": "*",
            "Condition": {
                "StringNotEquals": {
                    "aws:RequestedRegion": [
                        "ap-northeast-2",
                        "us-east-1"
                    ]
                }
            }
        },
        {
            "Sid": "limitedSize",
            "Effect": "Deny",
            "Action": "ec2:RunInstances",
            "Resource": "arn:aws:ec2:*:*:instance/*",
            "Condition": {
                "ForAnyValue:StringNotLike": {
                    "ec2:InstanceType": [
                        "*.nano",
                        "*.small",
                        "*.micro",
                        "*.medium"
                    ]
                }
            }
        },
        {
            "Sid": "limitedSizeRDS",
            "Effect": "Deny",
            "Action": [
                "rds:CreateDBInstance",
                "rds:CreateDBCluster"
            ],
            "Resource": "arn:aws:rds:*:*:db:*",
            "Condition": {
                "ForAnyValue:StringNotLike": {
                    "rds:DatabaseClass": [
                        "db.*.nano",
                        "db.*.small",
                        "db.*.micro",
                        "db.*.medium"
                    ]
                }
            }
        },
        {
            "Sid": "DenyEIP",
            "Effect": "Deny",
            "Action": [
                "ec2:AllocateAddress"
            ],
            "Resource": "*"
        },
        {
            "Sid": "DenyDeleteMFADevice",
            "Effect": "Deny",
            "Action": [
                "iam:DeleteVirtualMFADevice",
                "iam:DeactivateMFADevice"
            ],
            "Resource": "*"
        },
        {
            "Sid": "DenyPublicAccess",
            "Effect": "Deny",
            "Action": [
                "s3:PutAccountPublicAccessBlock",
                "s3:PutBucketPublicAccessBlock"
            ],
            "Resource": "*"
        },
        {
            "Sid": "DenyUserAction",
            "Effect": "Deny",
            "Action": [
                "iam:CreateGroup",
                "iam:AddUserToGroup",
                "iam:RemoveUserFromGroup",
                "iam:DeleteGroup",
                "iam:AttachGroupPolicy",
                "iam:UpdateUser",
                "iam:UpdateGroup",
                "iam:DetachGroupPolicy",
                "iam:DeleteUser",
                "iam:DeleteGroupPolicy",
                "iam:CreateUser",
                "iam:PutGroupPolicy"
            ],
            "Resource": "*"
        }
    ]
  }
EOF
}
