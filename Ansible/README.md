Install latest WordPress on Ubuntu

ROLES:
* core_components : Install mysql, nginx, php-*, etc. Configure nginx. 
* mysql: Create DB, User, give user access to DB
* wordpress: Download anc donfigure wordpress

HOW-TO:
* Put IP address of your machine to [web] group of hosts file
* Specify password for wordpress DB user in roles/mysql/defaults/mail.yml
* ansible-playbook wordpress.yml -u ubuntu --key-file /path/to/aws_keypair/key.pem --inventory-file hosts

