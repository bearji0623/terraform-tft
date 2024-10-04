#!/bin/bash
sudo yum install tomcat9 -y
sudo yum install java-17-amazon-corretto-devel.x86_64 -y

sudo yum install tomcat9-webapps.noarch -y

sudo systemctl start tomcat9
sudo systemctl enable tomcat9
sudo systemctl status tomcat9


#############################

wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
sudo yum localinstall mysql57-community-release-el7-11.noarch.rpm -y
sudo yum install mysql-community-server-5.7.12-1.el7.x86_64 -y

sudo systemctl start mysqld 
sudo systemctl status mysqld

#########################

#!/bin/bash

# Ensure the necessary directories exist
mkdir -p /var/lib/tomcat9/webapps/ROOT

# Replace the content of index.jsp with the new content
sudo wget https://github.com/startbootstrap/startbootstrap-sb-admin/archive/gh-pages.zip -O startbootstrap.zip
sudo unzip startbootstrap.zip -d /var/lib/tomcat9/webapps/ROOT/

sudo mv /var/lib/tomcat9/webapps/ROOT/startbootstrap-sb-admin-gh-pages/* /var/lib/tomcat9/webapps/ROOT/
sudo rm -rf /var/lib/tomcat9/webapps/ROOT/startbootstrap-sb-admin-gh-pages/