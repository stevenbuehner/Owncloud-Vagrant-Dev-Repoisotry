#!/usr/bin/env bash

# Install tools
apt-get -q -y install php5-xdebug

# If $FILE include $STRING ...
XDEBUG_CONF_FILE=/etc/php5/mods-available/xdebug.ini
XDEBUG_SEARCH_PHRASE=xdebug.remote_connect_back
if [ ! -z $(grep "$XDEBUG_SEARCH_PHRASE" "$XDEBUG_CONF_FILE") ]; then 
echo "Xdebug is already configured"; 
else
echo "xdebug.remote_enable = on" >> "$XDEBUG_CONF_FILE"
echo "xdebug.remote_connect_back = on" >> "$XDEBUG_CONF_FILE"
echo 'xdebug.idekey = "vagrant"' >> "$XDEBUG_CONF_FILE"
echo "xdebug.remote_port = 9000" >> "$XDEBUG_CONF_FILE"
fi

service apache2 restart
