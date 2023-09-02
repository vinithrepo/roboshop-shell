echo -e "\e[32m<<<<<<catalogue service >>>>\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service &>/tmp/roboshop.log
echo -e "\e[32m<<<<<< mongo repo >>>>\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>/tmp/roboshop.log
echo -e "\e[32m<<<<<<rpm >>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>/tmp/roboshop.log
echo -e "\e[32m<<<<<<nodejs >>>>\e[0m"
yum install nodejs -y &>/tmp/roboshop.log
echo -e "\e[32m<<<<<<useradd >>>>\e[0m"
useradd roboshop &>/tmp/roboshop.log
echo -e "\e[32m<<<<<<rm dir >>>>\e[0m"
rm -rf /app &>/tmp/roboshop.log
echo -e "\e[32m<<<<<<create dir >>>>\e[0m"
mkdir /app &>/tmp/roboshop.log
echo -e "\e[32m<<<<<<catalogue zip >>>>\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>/tmp/roboshop.log
echo -e "\e[32m<<<<<<cdapp >>>>\e[0m"
cd /app &>/tmp/roboshop.log
echo -e "\e[32m<<<<<<unzip >>>>\e[0m"
unzip /tmp/catalogue.zip &>/tmp/roboshop.log
echo -e "\e[32m<<<<<<cdapp >>>>\e[0m"
cd /app &>/tmp/roboshop.log
echo -e "\e[32m<<<<<<dependies download >>>>\e[0m"
npm install &>/tmp/roboshop.log
echo -e "\e[32m<<<<<<install mongo >>>>\e[0m"
yum install mongodb-org-shell -y &>/tmp/roboshop.log
echo -e "\e[32m<<<<<<host mongo >>>>\e[0m"
mongo --host mongodb.akhildevops.online </app/schema/catalogue.js &>/tmp/roboshop.log
echo -e "\e[32m<<<<<< reload restart >>>>\e[0m"
# update mongo ip address
# update catalogue server ip address in frontend configuration
systemctl daemon-reload &>/tmp/roboshop.log
systemctl enable catalogue &>/tmp/roboshop.log
systemctl restart catalogue &>/tmp/roboshop.log

