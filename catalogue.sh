
echo ">>>> Hello World <<<<"
cp catalogue.service /etc/systemd/system/catalogue.service
echo ">>>> Hello World <<<<"
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo ">>>> Hello World <<<<"
dnf module disable nodejs -y
echo ">>>> Hello World <<<<"
dnf module enable nodejs:18 -y
echo ">>>> Hello World <<<<"
dnf install nodejs -y
echo ">>>> Hello World <<<<"
useradd roboshop
echo ">>>> Hello World <<<<"
mkdir /app
echo ">>>> Hello World <<<<"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
echo ">>>> Hello World <<<<"
cd /app
unzip /tmp/catalogue.zip

cd /app
echo ">>>> Hello World <<<<"
npm install
echo ">>>> Hello World <<<<"
dnf install mongodb-org-shell -y

echo ">>>> Hello World <<<<"

mongo --host mongodb.vinithaws.online </app/schema/catalogue.js

echo ">>>> Hello World <<<<"

systemctl daemon-reload

systemctl enable catalogue
systemctl restart catalogue

