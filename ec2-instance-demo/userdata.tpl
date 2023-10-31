#!/bin/bash
yum update -y
yum install -y httpd
service httpd restart
systemctl start httpd
systemctl enable httpd
chkconfig httpd on
echo "<html><body>Hello welcome to course </body></html>" > /var/www/html/index.html