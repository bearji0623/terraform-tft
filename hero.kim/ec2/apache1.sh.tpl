#!/bin/bash
# Update the package list
yum update -y

# Install Apache (httpd)
yum install -y httpd

# Start the Apache service
systemctl start httpd

# Enable Apache to start on boot
systemctl enable httpd

# Create a simple index.html file
echo "<html><body><h1>94102108-laC-TFT-Second!</h1></body></html>" > /var/www/html/index.html

# Load Apache proxy modules
echo "LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_http_module modules/mod_proxy_http.so"

# Configure the VirtualHost with NLB DNS
echo "<VirtualHost *:80>
  ProxyRequests off
  ProxyPreserveHost On
  ProxyPass / http://${NLB_DNS_NAME}:8080/ acquire=3000 timeout=600 Keepalive=On
  ProxyPassReverse / http://${NLB_DNS_NAME}:8080/
</VirtualHost>" >> /etc/httpd/conf/httpd.conf

# Restart Apache to apply the changes
systemctl restart httpd