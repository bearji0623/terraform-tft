#키페어 생성
resource "aws_key_pair" "tt" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}
