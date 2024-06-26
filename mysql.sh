mysql_root_password=$1

cp mysql.repo  /etc/yum.repos.d/mysql.repo

dnf module disable mysql -y

dnf install mysql-community-server -y

systemctl enable mysqld
systemctl restart mysqld

mysql_secure_installation --set-root-pass ${mysql_root_password}


