### SG PRIVATE RDS ###
resource "aws_security_group" "juno-sg-rds" {
  vpc_id      = var.vpc_id
  name        = "JUNO-SG-RDS"
  description = "JUNO-SG-RDS"
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks     = ["10.0.2.0/24"]
    description = "WAS_SUB_A CIDR"
  }
    ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks     = ["10.0.12.0/24"]
    description = "WAS_SUB_C CIDR"
  }
  
  tags = {
    Name = "JUNO-SG-RDS"
  }
}