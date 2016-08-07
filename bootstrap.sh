#!/usr/bin/env bash

MYSQL_ADMIN_PASS=adminpass
MYSQL_DEFAULT_DB=owncloud
OWNCLOUD_BRANCH=stable9
WEBSERVER_ROOT=/var/www/html
apt-get update

# Install tools
apt-get -q -y install wget

# Install Mysql silently
export DEBIAN_FRONTEND=noninteractive
apt-get -q -y install mysql-server
mysqladmin -u root password $MYSQL_ADMIN_PASS

# Allow MySQL Port-Forwarding
sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/g' /etc/mysql/my.cnf
mysql -u root -p$MYSQL_ADMIN_PASS -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ADMIN_PASS' WITH GRANT OPTION; FLUSH PRIVILEGES;"
sudo service mysql restart

# Create default Mysql-DB
mysql -u root -p$MYSQL_ADMIN_PASS -e "CREATE DATABASE $MYSQL_DEFAULT_DB"

# Setup Apache with phpmodules
apt-get install -y apache2 

# Setup PHP 5.6 (Default php 5.5)
add-apt-repository ppa:ondrej/php5-5.6
apt-get update
# apt-get install python-software-properties # on error only

# Install php and modules
apt-get install -y php5 
apt-get install -y php5-imagick mysql-server php5-mysql php5-mcrypt php5-curl php5-imap php5-gd php5-sqlite
php5 -v

# Install Phpunit
cd /tmp
wget -c https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
mv phpunit.phar /usr/local/bin/phpunit
phpunit --version

# install Owncloud requirements
apt-get install -y git python3 python3-pip python3-jinja2
apt-get install rsync
python --version

# Owncloud Dev-Tool
pip3 install ocdev
ocdev --version

# Owncloud base-setup
mkdir -p /tmp/owncloud
ocdev setup core --dir /tmp/owncloud/ --branch $OWNCLOUD_BRANCH --no-history
rsync -a /tmp/owncloud/ $WEBSERVER_ROOT/
rm -rf /tmp/owncloud
chown -R www-data.www-data $WEBSERVER_ROOT
# chmod 770 $WEBSERVER_ROOT/data
service apache2 restart

# set up mysql / Travis Default-DB
mysql -u root -p$MYSQL_ADMIN_PASS -e 'create database oc_autotest;'
mysql -u root -p$MYSQL_ADMIN_PASS -e "CREATE USER 'oc_autotest'@'localhost';"
mysql -u root -p$MYSQL_ADMIN_PASS -e "grant all on oc_autotest.* to 'oc_autotest'@'localhost';"
cd $WEBSERVER_ROOT
ocdev ci mysql

