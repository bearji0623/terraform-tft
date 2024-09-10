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
echo "<html><body><h1>94102108-laC-TFT-First!</h1></body></html>" > /var/www/html/index.html
