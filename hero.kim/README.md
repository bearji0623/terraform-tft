# Module 설명 

## VPC
- 필수 : name, cidr, az, subnets

### variables.tf
- vpc_cidr
- az : 변동 가능
- public_subnets : 내가 사용할 퍼블릭 범위나 갯수
- private_subnets : 내가 사용할 프라이빗 범위나 갯수
- nat_gateway : 기본값은 true

### outputs.tf
- vpc_id : 다른 모듈에서 vpc를 사용할때 (ex. alb 생성, rds 생성) 
- public_subnets : 다른 모듈에서 서브넷을 필요로 할때 (ex. alb 생성, rds 생성)
- private_subnets : 다른 모듈에서 서브넷을 필요로 할때 (ex. alb 생성, rds 생성)


## EC2
- 필수 : name, instance type, key, security group, subnet 
