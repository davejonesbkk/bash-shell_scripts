#!/bin/bash

#Setup LAMP server with Wordpress:
#1 - Install & activate httpd
#2 - Install, activate & secure mysqld
#3 - Install php & mods
#4 - Download & unpack WP
#5 - Config WP
#6 - Send email with summary

PHPVERSION=`php -v`

WPDB_USER=wp-user

WPDB_NAME=wp-database

WPDB_PW=`openssl rand -base64 32`

echo "--> Updating Centos"

yum -y update

echo "--> Downloading &installing Apache"

yum -y install httpd

echo "--> Starting & enabling Apache"

systemctl start httpd &&  systemctl enable httpd

echo "--> Installing Mysql"

yum -y install mariadb mariadb-server

echo "--> Starting & enabling Mysql"

systemctl start mariadb &&  systemctl enable mariadb

echo "--> Securing Mysql"

echo "To do later"
# mysql_secure_installation

echo "--> Installing php & mods"

yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm

yum -y install yum-utils

yum-config-manager --enable remi-php70

yum -y install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo

echo $PHPVERSION

wget -P /tmp https://wordpress.org/latest.zip

unzip /tmp/latest.zip -d /var/www/html/
cp -r /var/www/html/wordpress/* /var/www/html/

rm -rf /var/www/html/wordpress

#Change WP database details in wp-config.php

mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

sed -i "s/database_name_here/${WPDB_NAME}/g" /var/www/html/wp-config.php

sed -i "s/password_here/${WPDB_PW}/g" /var/www/html/wp-config.php

sed -i "s/username_here/${WPDB_USER}/g" /var/www/html/wp-config.php
