vinith=/tmp/roboshop.log
echo -e "\e[32m<<<<<<${component} service >>>>\e[0m"
cp shipping.service /etc/systemd/system/shipping.service &>>${vinith}
echo -e "\e[32m<<<<<<${component} install maven >>>>\e[0m"
yum install maven -y  &>>${vinith}
echo -e "\e[32m<<<<<<useradd >>>>\e[0m"
useradd roboshop &>>${vinith}
echo -e "\e[32m<<<<<<rm dir >>>>\e[0m"
rm -rf /app &>>${vinith}
echo -e "\e[32m<<<<<<create dir >>>>\e[0m"
mkdir /app &>>${vinith}
echo -e "\e[32m<<<<<<${component} zip >>>>\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>${vinith}
echo -e "\e[32m<<<<<<cdapp >>>>\e[0m"
cd /app &>>${vinith}
echo -e "\e[32m<<<<<<unzip >>>>\e[0m"
unzip /tmp/shipping.zip &>>${vinith}
echo -e "\e[32m<<<<<<cdapp >>>>\e[0m"
cd /app &>>${vinith}
echo -e "\e[32m<<<<<<${component} clean >>>>\e[0m"
mvn clean package &>>${vinith}
echo -e "\e[32m<<<<<<${component} jar >>>>\e[0m"
mv target/shipping-1.0.jar shipping.jar &>>${vinith}
echo -e "\e[32m<<<<<<${component} install mysql >>>>\e[0m"
yum install mysql -y &>>${vinith}
echo -e "\e[32m<<<<<<${component} uroot >>>>\e[0m"
mysql -h mysql.akhildevops.online -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>${vinith}
echo -e "\e[32m<<<<<<${component} reload start >>>>\e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping
