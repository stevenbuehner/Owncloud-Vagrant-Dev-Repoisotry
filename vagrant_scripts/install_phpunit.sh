#!/usr/bin/env bash

# Install Phpunit
if [ ! -f /tmp/foo.txt ]; then
    echo "Install Phpunit"
    cd /tmp
	wget --quiet -c https://phar.phpunit.de/phpunit.phar
	chmod +x phpunit.phar
	mv phpunit.phar /usr/local/bin/phpunit
fi

phpunit --version
