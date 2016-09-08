#!/usr/bin/env bash

# Install tools
apt-get update
apt-get -q -y install wget

# Setup PHP 5.6 (Default php 5.5)
add-apt-repository ppa:ondrej/php5-5.6
apt-get update
# apt-get install python-software-properties # on error only

# Setup Apache with phpmodules
apt-get install -y apache2 

# Make apache2-log dir readable
# Feature: Read the Apache-Error-Logfile directly from host via: vagrant ssh -c "sudo tail -f /var/log/apache2/error.log"
mkdir -p /var/log/apache2
chmod o+x,o+r /var/log/apache2

# Install php and modules
apt-get install -y php5 
apt-get install -y php5-imagick mysql-server php5-mysql php5-mcrypt php5-curl php5-imap php5-gd php5-sqlite
php5 -v

# Disable the Automatically populating $HTTP_RAW_POST_DATA (will be in future anyway)
sed -i 's/;\s*always_populate_raw_post_data/always_populate_raw_post_data/' "/etc/php5/apache2/php.ini"

# Reload Apache (with changed php.ini)
service apache2 reload