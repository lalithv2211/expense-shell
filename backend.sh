source common.sh

db_installation_password=$1

if [ -z "$db_installation_password" ]; then
  echo "password is empty, please rerun with correct password param"
  exit 1
fi

printing_the_header "Disable default NodeJS Version Module"
dnf module disable nodejs -y &>> $log_file
if [ $? -eq 0]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "Enable NodeJS module for V20"
dnf module enable nodejs:20 -y &>> $log_file
if [ $? -eq 0]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "Install NodeJS"
dnf install nodejs -y &>>$log_file 
if [ $? -eq 0]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "Remove old files"
rm -rf /app &>>$log_file
if [ $? -eq 0]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "copying the service file"
cp backend.service /etc/systemd/system/backend.service &>>$log_file
if [ $? -eq 0]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "adding user"
useradd expense &>>$log_file
if [ $? -eq 0]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "creating a new /app folder"
mkdir /app &>>$log_file
if [ $? -eq 0]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "downloading the backend zip file"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>$log_file
if [ $? -eq 0]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "unzipping the downloaded zip file"
cd /app &>>$log_file
unzip /tmp/backend.zip &>>$log_file
if [ $? -eq 0]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "npm install packages"
cd /app &>>$log_file
npm install &>>$log_file
if [ $? -eq 0]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "daemon-reload step"
systemctl daemon-reload &>>$log_file
if [ $? -eq 0]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "starting the backend service"
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
if [ $? -eq 0]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "installing the mysql"
dnf install mysql -y &>>$log_file
if [ $? -eq 0]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "connecting to Database"
mysql -h 172.31.27.94 -uroot -p$db_installation_password < /app/schema/backend.sql &>>$log_file
if [ $? -eq 0]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "restarting the backend service"
systemctl restart backend &>>$log_file
systemctl status backend &>>$log_file
if [ $? -eq 0]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi