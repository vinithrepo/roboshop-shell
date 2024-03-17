cp catalogue.service /etc/systemd/system/catalogue.service
cp mongo.repo /etc/yum.repos.d/mongo.repo

yum module disable nodejs -y

yum module enable nodejs:18 -y

yum install nodejs -y

yum install mongodb-org-shell -y

mongo --host 172.31.32.49 </app/schema/catalogue.js

useradd roboshop

mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip

cd /app
npm install

systemctl daemon-reload

systemctl enable catalogue
systemctl restart catalogue



