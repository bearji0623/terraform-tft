# Module 작성시 참고사항
## VPC
- vpc
- public subnet
- private subnet
- igw
- nat gateway
- az
- (optional) route table

## WEB Server (EC2)
- name
- ami
- type
- sg -> 참조하는 형식
- key_pair
- subnet
- ebs (root volume)
- ebs (data volume)
- user data -> apache 설치

## WAS Server (EC2)
- name
- ami
- type
- sg -> 참조하는 형식
- key_pair
- subnet
- ebs (root volume)
- user data -> tomcat 설치

## Security Group
- web, was, alb, rds 한곳에 모듈 하나로

## ALB
- name
- subnet
- internet-facing
- type
- sg -> 참조하는 형식
- listener -> HTTP(80), HTTPS(443)
- listener rule -> 80 -> 443 redirect
- default action (확인 필요)
- target group

## NLB
- name
- subnet
- internal
- type
- sg -> 참조하는 형식
- listener -> 8080
- default action (확인 필요)
- target group

## RDS
- name
- subnet group
- parameter group
- option group
- sg - 참조
- engine -> mysql
- engine version -> 5.7
- multi-az -> true
- username -> admin
- password -> a123456789
- db_name
- instance class
- storage 크기
- public, private 접근 -> private 접근만 가능하게 설정 
- auto minor version upgrade -> false 

