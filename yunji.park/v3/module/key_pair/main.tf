# RSA 알고리즘을 사용해 private 키 생성
resource "tls_private_key" "pk" {
    algorithm = "RSA"
    rsa_bits = 4096
}

# private 키를 가지고 key pair 생성
resource "aws_key_pair" "key" {
    key_name = var.key_name
    public_key = tls_private_key.pk.public_key_openssh
}

# 키파일 생성 후 로컬에 다운로드 
resource "local_file" "ssh_key" {
    filename = var.key_file_name
    content = tls_private_key.pk.private_key_pem
}