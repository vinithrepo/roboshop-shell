cp mysql.repo  /etc/yum.repos.d/mysql.repo

dnf module disable mysql -y

dnf install mysql-community-server -y

mysql_secure_installation --set-root-pass RoboShop@1


systemctl enable mysqld
systemctl restart mysqld
