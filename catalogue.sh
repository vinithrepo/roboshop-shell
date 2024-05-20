
echo ">>>> creating catalogue service  <<<<"
cp catalogue.service /etc/systemd/system/catalogue.service
echo ">>>> mongo repo <<<<"
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo ">>>> disable nodejs <<<<"
dnf module disable nodejs -y
echo ">>>> enable nodejs`` <<<<"
dnf module enable nodejs:18 -y
echo ">>>> install nodejs <<<<"
dnf install nodejs -y
echo ">>>> adding user  <<<<"
useradd roboshop

mkdir /app
echo ">>>> dowlnloading zip <<<<"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
echo ">>> extracting zip <<<"
cd /app
unzip /tmp/catalogue.zip

cd /app
echo ">>>> dowlnloading dependencies <<<<"
npm install
echo ">>>> install DB shell <<<<"
dnf install mongodb-org-shell -y

echo ">>>> load schema <<<<"

mongo --host mongodb.vinithaws.online </app/schema/catalogue.js

echo ">>>> start service <<<<"

systemctl daemon-reload

systemctl enable catalogue
systemctl restart catalogue

