#! /bin/bash
yum -y install httpd --setopt=timeout=60 --setopt=retries=3
systemctl start httpd
systemctl enable httpd
echo "$(hostname)" >> /var/www/html/index.html