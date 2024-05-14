cp cart.service  /etc/systemd/system/cart.service

dnf module disable nodejs -y
dnf module enable nodejs:18 -y

dnf install nodejs -y

useradd roboshop

mkdir /app

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
unzip /tmp/cart.zip

cd /app
npm install

systemctl daemon-reload

systemctl enable cart
systemctl start cart

