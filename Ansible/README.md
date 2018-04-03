Install latest WordPress on Ubuntu

ROLES:
* core_components : Install mysql, nginx, php-*, etc. Configure nginx. 
* mysql: Create DB, User, give user access to DB
* wordpress: Download anc donfigure wordpress

USAGE:
ansible-playbook wordpress.yml -u ubuntu --key-file /home/ec2-user/key.pem
