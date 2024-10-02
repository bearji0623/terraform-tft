# Module 설명 

## VPC
- 필수 : name, cidr, az, subnets

### variables.tf
- vpc-cidr
- az : 변동 가능
- public-subnets : 내가 사용할 퍼블릭 범위나 갯수
- private-subnets : 내가 사용할 프라이빗 범위나 갯수
- nat-gateway : 기본값은 true

### outputs.tf
- vpc_id : 다른 모듈에서 vpc를 사용할때 
- public-subnets
- private-subnets

