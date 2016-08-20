#!/usr/bin/env bash

# Install composer
if [ ! -f /usr/local/bin/composer ]; then
    echo "Install Composer"
    apt-get install -y curl php5-cli git
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
fi

composer --version
