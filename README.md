# owncloud-vagrant-dev-enviornment
This is just a small setup to use developp owncloud apps in a vagrant environment. I wanted to see exactly what is installed in the vm and therefore created my own vagrant setup with a transparent SHELL bootstrap.

# Usage Advantages
- Owncloud is completely setup with current branch "stable9"
- Owncloud will run on http://localhost:5000
- MySql DB accessible with external apps (Sequel Pro, ...) at localhost:5001 with username "root" and password "adminpass
- /var/www/html has user:group permissions of www-data:www-data
- all the data can be modified on the host in "./www" or the vm in "/vagrant/www"

# Default Usernames / Passwords
- SQL-DB: oc_autotest
- SQL-User: oc_autotest
- SQL-Password:
- MySql "root" Password: adminpass
- Owncloud-Username: admin
- Owncloud "admin" Password: admin
