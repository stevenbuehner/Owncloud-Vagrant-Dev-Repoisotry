#!/usr/bin/env bash

#Mysql
if [ -z ${MYSQL_DB_NAME+x} ]; then MYSQL_DB_NAME=defaultdb; else echo "Override MYSQL_DB_NAME='$MYSQL_DB_NAME'."; fi
