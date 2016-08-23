#!/usr/bin/env bash

if [ -z ${MYSQL_ROOT_USER+x} ]; then MYSQL_ROOT_USER=root; else echo "Override MYSQL_ROOT_USER='$MYSQL_ROOT_USER'."; fi
if [ -z ${MYSQL_ROOT_PASS+x} ]; then MYSQL_ROOT_PASS=adminpass; else echo "Override MYSQL_ROOT_PASS='$MYSQL_ROOT_PASS'."; fi

if [ -z ${MYSQL_USER_NAME+x} ]; then MYSQL_USER_NAME=oc_autotest; else echo "Override MYSQL_USER_NAME='$MYSQL_USER_NAME'."; fi
if [ -z ${MYSQL_DB+x} ]; then MYSQL_DB=oc_autotest; else echo "Override MYSQL_DB='$MYSQL_DB'."; fi
if [ -z ${OWNCLOUD_BRANCH+x} ]; then OWNCLOUD_BRANCH=stable9; else echo "Override OWNCLOUD_BRANCH='$OWNCLOUD_BRANCH'."; fi
if [ -z ${WEBSERVER_ROOT+x} ]; then WEBSERVER_ROOT=/var/www/html; else echo "Override WEBSERVER_ROOT='$WEBSERVER_ROOT'."; fi


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
# Only sync changed files
rsync -arc /tmp/owncloud/ $WEBSERVER_ROOT/
rm -rf /tmp/owncloud
chown -R www-data.www-data $WEBSERVER_ROOT
# chmod 770 $WEBSERVER_ROOT/data
service apache2 restart

# set up mysql / Travis Default-DB
mysql -u $MYSQL_ROOT_USER -p$MYSQL_ROOT_PASS -e "CREATE DATABASE $MYSQL_DEFAULT_DB"
mysql -u $MYSQL_ROOT_USER -p$MYSQL_ROOT_PASS -e "CREATE USER '$MYSQL_USER_NAME'@'localhost';"
mysql -u $MYSQL_ROOT_USER -p$MYSQL_ROOT_PASS -e "grant all on $MYSQL_USER_NAME.* to '$MYSQL_DB'@'localhost';"
cd $WEBSERVER_ROOT
ocdev ci mysql

# Change Data-Directory
sed -i 's/.*datadirectory.*/"datadirectory" => "\/var\/www\/data",/g' /vagrant/www/config/config.php
