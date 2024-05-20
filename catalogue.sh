
echo  -e "\e[32m>>>> creating catalogue service  <<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service
echo  -e "\e[32m>>>> mongo repo <<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo  -e "\e[32m>>>> disable nodejs <<<<\e[0m"
dnf module disable nodejs -y
echo  -e "\e[32m>>>> enable nodejs`` <<<<\e[0m"
dnf module enable nodejs:18 -y
echo  -e "\e[32m>>>> install nodejs <<<<\e[0m"
dnf install nodejs -y
echo  -e "\e[32m>>>> adding user  <<<<\e[0m"
useradd roboshop
echo  -e "\e[32m>>>> cleaning directory  <<<<\e[0m"
rm -rf /app

mkdir /app
echo  -e "\e[32m>>>> dowlnloading zip <<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
echo  -e "\e[32m>>> extracting zip <<<\e[0m"
cd /app
unzip /tmp/catalogue.zip

cd /app
echo  -e "\e[32m>>>> dowlnloading dependencies <<<<\e[0m"
npm install
echo  -e "\e[32m>>>> install DB shell <<<<\e[0m"
dnf install mongodb-org-shell -y

echo  -e "\e[32m>>>> load schema <<<<\e[0m"

mongo --host mongodb.vinithaws.online </app/schema/catalogue.js

echo  -e "\e[32m>>>> start service <<<<\e[0m"

systemctl daemon-reload

systemctl enable catalogue
systemctl restart catalogue

