#! /bin/bash

# EBS 볼륨 마운트
# /data001 디렉터리 생성
mkdir -p /data001

# /dev/sdf에 파일 시스템이 있는지 확인 후 없으면 XFS로 포맷
if ! file -s /dev/sdf | grep -q "XFS"; then
  mkfs.xfs /dev/sdf
fi

# /dev/sdf를 /data001에 마운트
mount /dev/sdf /data001

# fstab에 추가하여 재부팅 시에도 자동 마운트되도록 설정
echo "/dev/sdf /data001 xfs defaults,nofail 0 2" >> /etc/fstab

# Apache 설치 및 시작
yum -y install httpd --setopt=timeout=60 --setopt=retries=3
systemctl start httpd
systemctl enable httpd

# EC2 인스턴스의 호스트네임을 웹 페이지에 출력
echo "$(hostname)" >> /var/www/html/index.html
