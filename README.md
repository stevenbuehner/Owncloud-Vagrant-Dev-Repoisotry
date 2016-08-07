# Description
This is just a small setup to developp apps for owncloud using a vagrant environment.
I wanted to see exactly what is installed on the vm and therefore created my own vagrant setup with a transparent SHELL bootstrap. I also added some features, that I don't want to setup every time in bootstrap.sh

# Usage Advantages
- Owncloud is completely setup with current branch "stable9"
- Owncloud will run on http://localhost:5000
- MySql DB accessible with external apps (Sequel Pro, ...) at localhost:5001 with username "root" and password "adminpass
- /var/www/html has user:group permissions of www-data:www-data
- all the data can be modified on the host in "./www" or the vm in "/vagrant/www"
- php 5.6, phpunit, owncloud dev-tools will be installed automatically

# Default Usernames / Passwords
- SQL-DB: oc_autotest
- SQL-User: oc_autotest
- SQL-Password:
- MySql "root" Password: adminpass
- Owncloud-Username: admin
- Owncloud "admin" Password: admin
