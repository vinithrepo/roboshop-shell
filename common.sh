vinith=/tmp/roboshop.log

func_apppreq() {
    echo -e "\e[32m<<<<<<${component} service >>>>\e[0m"
    cp ${component}.service /etc/systemd/system/${component}.service &>>${vinith}
    
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

}

func_systemd() {
    echo -e "\e[32m<<<<<< reload restart >>>>\e[0m"
    systemctl daemon-reload &>>${vinith}
    systemctl enable ${component} &>>${vinith}
    systemctl restart ${component} &>>${vinith}
}

func_nodejs() {

  echo -e "\e[32m<<<<<<${component} service >>>>\e[0m"
  cp ${component}.service /etc/systemd/system/${component}.service &>>${vinith}
  echo -e "\e[32m<<<<<<${component} repo >>>>\e[0m"
  cp mongo.repo /etc/yum.repos.d/mongo.repo &>>${vinith}
  echo -e "\e[32m<<<<<<rpm >>>>\e[0m"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${vinith}
  echo -e "\e[32m<<<<<<nodejs >>>>\e[0m"
  yum install nodejs -y &>>${vinith}

  func_apppreq

  echo -e "\e[32m<<<<<<dependies download >>>>\e[0m"
  npm install &>>${vinith}
  echo -e "\e[32m<<<<<<install mongo >>>>\e[0m"
  yum install mongodb-org-shell -y &>>${vinith}
  echo -e "\e[32m<<<<<<host mongo >>>>\e[0m"
  mongo --host mongodb.akhildevops.online </app/schema/${component}.js &>>${vinith}

  func_systemd
}

func_java() {
  
  echo -e "\e[32m<<<<<<${component} install maven >>>>\e[0m"
  yum install maven -y  &>>${vinith}

  func_apppreq

  echo -e "\e[32m<<<<<<${component} clean >>>>\e[0m"
  mvn clean package &>>${vinith}
  echo -e "\e[32m<<<<<<${component} jar >>>>\e[0m"
  mv target/${component}-1.0.jar ${component}.jar &>>${vinith}
  echo -e "\e[32m<<<<<< install mysql >>>>\e[0m"
  yum install mysql -y &>>${vinith}
  echo -e "\e[32m<<<<<< load schema >>>>\e[0m"
  mysql -h mysql.akhildevops.online -uroot -pRoboShop@1 < /app/schema/${component}.sql &>>${vinith}

  func_systemd
}
func_python() {
  echo -e "\e[32m<<<<<<${component} install python >>>>\e[0m"
  yum install python36 gcc python3-devel -y &>>${vinith}

  func_apppreq

  echo -e "\e[32m<<<<<<${component} requirements >>>>\e[0m"
  pip3.6 install -r requirements.txt &>>${vinith}

  func_systemd
}