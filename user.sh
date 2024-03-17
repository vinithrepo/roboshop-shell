cp user.service /etc/systemd/system/user.service

yum module disable nodejs -y
yum module enable nodejs:18 -y

yum install nodejs -y

useradd roboshop

mkdir /app

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
unzip /tmp/user.zip

cd /app
npm install

systemctl daemon-reload

systemctl enable user
systemctl restart user
