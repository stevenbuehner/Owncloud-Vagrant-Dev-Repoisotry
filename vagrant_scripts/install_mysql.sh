#!/usr/bin/env bash

#Mysql
if [ -z ${MYSQL_ROOT_PASS+x} ]; then MYSQL_ROOT_PASS=adminpass; else echo "Override MYSQL_ROOT_PASS='$MYSQL_ROOT_PASS'."; fi
if [ -z ${MYSQL_ROOT_USER+x} ]; then MYSQL_ROOT_USER=root; else echo "Override MYSQL_ROOT_USER='$MYSQL_ROOT_USER'."; fi

# Install Mysql silently
export DEBIAN_FRONTEND=noninteractive
apt-get -q -y install mysql-server
mysqladmin -u root password $MYSQL_ROOT_PASS

# Allow MySQL Port-Forwarding
sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/g' /etc/mysql/my.cnf
mysql -u $MYSQL_ROOT_USER -p$MYSQL_ROOT_PASS -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_ROOT_USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASS' WITH GRANT OPTION; FLUSH PRIVILEGES;"
sudo service mysql restart

