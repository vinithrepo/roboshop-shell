nodejs() {
  vinith=/tmp/roboshop.log
  echo -e "\e[32m<<<<<<${component} service >>>>\e[0m"
  cp ${component}.service /etc/systemd/system/${component}.service &>>${vinith}
  echo -e "\e[32m<<<<<< mongo repo >>>>\e[0m"
  cp mongo.repo /etc/yum.repos.d/mongo.repo &>>${vinith}
  echo -e "\e[32m<<<<<<rpm >>>>\e[0m"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${vinith}
  echo -e "\e[32m<<<<<<nodejs >>>>\e[0m"
  yum install nodejs -y &>>${vinith}
  echo -e "\e[32m<<<<<<useradd >>>>\e[0m"
  useradd roboshop &>>${vinith}
  echo -e "\e[32m<<<<<<rm dir >>>>\e[0m"
  rm -rf /app &>>${vinith}
  echo -e "\e[32m<<<<<<create dir >>>>\e[0m"
  mkdir /app &>>${vinith}
  echo -e "\e[32m<<<<<<${component} zip >>>>\e[0m"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${vinith}
  echo -e "\e[32m<<<<<<cdapp >>>>\e[0m"
  cd /app &>>${vinith}
  echo -e "\e[32m<<<<<<unzip >>>>\e[0m"
  unzip /tmp/${component}.zip &>>${vinith}
  echo -e "\e[32m<<<<<<cdapp >>>>\e[0m"
  cd /app &>>${vinith}
  echo -e "\e[32m<<<<<<dependies download >>>>\e[0m"
  npm install &>>${vinith}
  echo -e "\e[32m<<<<<<install mongo >>>>\e[0m"
  yum install mongodb-org-shell -y &>>${vinith}
  echo -e "\e[32m<<<<<<host mongo >>>>\e[0m"
  mongo --host mongodb.akhildevops.online </app/schema/${component}.js &>>${vinith}
  echo -e "\e[32m<<<<<< reload restart >>>>\e[0m"
  # update mongo ip address
  # update ${component} server ip address in frontend configuration
  systemctl daemon-reload &>>${vinith}
  systemctl enable ${component} &>>${vinith}
  systemctl restart ${component} &>>${vinith}
}