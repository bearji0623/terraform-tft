# dev 그룹 생성 및 정책 연결
resource "aws_iam_group" "dev" {
  name = "dev"
}

resource "aws_iam_group_policy_attachment" "dev_group_policy_attach" {
  group      = aws_iam_group.dev.name
  policy_arn = module.dev.dev_policy_id
}

# prd 그룹 생성 및 정책 연결
resource "aws_iam_group" "prod" {
  name = "prod"
}

resource "aws_iam_group_policy_attachment" "prod_group_policy_attach" {
  group      = aws_iam_group.prod.name
  policy_arn = module.prod.prod_policy_id
}

resource "aws_iam_group_policy_attachment" "prod_group_policy_attach1" {
  group      = aws_iam_group.prod.name
  policy_arn = module.prod.mfa_policy_id
}

resource "aws_iam_group_policy_attachment" "admin_policy_attach" {
  group      = aws_iam_group.prod.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# 신입사원 a(dev 그룹) 생성 및 할당
resource "aws_iam_user" "a" {
  name = "test1"
}

resource "aws_iam_user_group_membership" "dev_membership" {
  user   = aws_iam_user.a.name
  groups = [aws_iam_group.dev.name]
}

# 신입사원 b(prd 그룹) 생성 및 할당
resource "aws_iam_user" "b" {
  name = "test2"
}

resource "aws_iam_user_group_membership" "prd_membership" {
  user   = aws_iam_user.b.name
  groups = [aws_iam_group.prod.name]
}

resource "aws_iam_user_login_profile" "test_login" {
  user = aws_iam_user.a.name
  password_length = 8  # 자동 생성될 비밀번호 길이
  password_reset_required = true
}

resource "aws_iam_user_login_profile" "test_login1" {
  user = aws_iam_user.b.name
  password_length = 8  # 자동 생성될 비밀번호 길이
  password_reset_required = true
}
