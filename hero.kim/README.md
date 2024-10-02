# Module 설명

## 구성요소 
### main.tf
- 사용자가 생성할 리소스에 대한 정보가 담겨져 있는 파일

### variables.tf
- main.tf에 사용할 리소스에 대한 정보를 var 변수로 처리하여서 가지고 오게 하는 파일

### output.tf
- 사용자가 생성한 리소스의 모듈의 값을 도출하여 다른 모듈에서 사용하게 해주는 파일

## VPC
- 필수 : name, cidr, az, subnets

### variables.tf
- vpc_cidr : 사용자가 원하는 cidr 범위 설정 가능 -> 현재 10.10.0.0/20
- az : 사용자가 사용할 가용 영역의 종류나 갯수 -> 현재 ap-northeast-2a, ap-northeast-2c
- public_subnets : 사용자가 사용할 퍼블릭 범위나 갯수 -> 현재 2개
- private_subnets : 사용자가 사용할 프라이빗 범위나 갯수 -> 현재 6개
- nat_gateway : 기본값은 true
    enable_nat_gateway : nat_gateway를 사용 할 것인지?
    single_nat_gateway : nat_gateway를 1개 사용할 것인지?
    one_nat_gateway_per_az : 가용영역 당 nat_gateway를 사용할 것인지?

### outputs.tf
- vpc_id : 다른 모듈에서 vpc를 사용할때 (ex. alb 생성, rds 생성) 
- public_subnets : 다른 모듈에서 서브넷을 필요로 할때 (ex. alb 생성, rds 생성)
- private_subnets : 다른 모듈에서 서브넷을 필요로 할때 (ex. alb 생성, rds 생성)


## EC2
- 필수 : name, instance type, key, security group, subnet 
