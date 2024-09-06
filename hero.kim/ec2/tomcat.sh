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
cat <<EOL > /var/lib/tomcat9/webapps/ROOT/index.jsp
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
      <head><title>This is WAS1</title></head>
      <body>
          WAS-First TEST
          TIME IS <%= new java.util.Date()%>
      </body>
</html>
EOL