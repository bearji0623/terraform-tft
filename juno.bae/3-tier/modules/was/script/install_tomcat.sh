#! /bin/bash

# 톰캣 설치
yum -y install tomcat --setopt=timeout=60 --setopt=retries=3

# 톰캣 시작, 자동 재시작 설정
systemctl start tomcat
systemctl enable tomcat