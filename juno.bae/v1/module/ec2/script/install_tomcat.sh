#! /bin/bash
yum -y install tomcat --setopt=timeout=60 --setopt=retries=3
systemctl start tomcat
systemctl enable tomcat