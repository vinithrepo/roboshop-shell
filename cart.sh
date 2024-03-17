cp cart.service /etc/systemd/system/cart.service

yum module disable nodejs -y
yum module enable nodejs:18 -y

yum install nodejs -y

useradd roboshop

mkdir /app

curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
unzip /tmp/cart.zip

cd /app
npm install

systemctl daemon-reload

systemctl enable cart
systemctl restart cart
