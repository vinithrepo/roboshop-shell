log=/tmp/roboshop.log

echo  -e "\e[32m>>>> creating catalogue service  <<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service  &>>{log}
echo  -e "\e[32m>>>> mongo repo <<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo   &>>{log}
echo  -e "\e[32m>>>> disable nodejs <<<<\e[0m"
dnf module disable nodejs -y   &>>{log}
echo  -e "\e[32m>>>> enable nodejs`` <<<<\e[0m"
dnf module enable nodejs:18 -y    &>>{log}
echo  -e "\e[32m>>>> install nodejs <<<<\e[0m"
dnf install nodejs -y   &>>{log}
echo  -e "\e[32m>>>> adding user  <<<<\e[0m"
useradd roboshop   &>>{log}
echo  -e "\e[32m>>>> cleaning directory  <<<<\e[0m"
rm -rf /app  &>>{log}

mkdir /app
echo  -e "\e[32m>>>> dowlnloading zip <<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip   &>>{log}
echo  -e "\e[32m>>> extracting zip <<<\e[0m"
cd /app
unzip /tmp/catalogue.zip  &>>{log}

cd /app
echo  -e "\e[32m>>>> dowlnloading dependencies <<<<\e[0m"
npm install   &>>{log}
echo  -e "\e[32m>>>> install DB shell <<<<\e[0m"
dnf install mongodb-org-shell -y   &>>{log}

echo  -e "\e[32m>>>> load schema <<<<\e[0m"

mongo --host mongodb.vinithaws.online </app/schema/catalogue.js   &>>{log}

echo  -e "\e[32m>>>> start service <<<<\e[0m"

systemctl daemon-reload

systemctl enable catalogue
systemctl restart catalogue

