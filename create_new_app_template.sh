#!/usr/bin/env bash


MYSQL_ADMIN_PASS=adminpass
MYSQL_DEFAULT_DB=oc_autotest
MYSQL_DEFAULT_USER=oc_autotest
OWNCLOUD_BRANCH=stable9

cd /vagrant/www/apps
ocdev startapp Knowledgebase --email buehner@me.com --author "Steven Bühner" --description "A base to collect and organize all kind of data (tag based, bible verse based, ...)" --owncloud 9

