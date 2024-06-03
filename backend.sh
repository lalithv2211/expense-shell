source common.sh

db_installation_password=$1

if [ ! -z "$db_installation_password" ]; then
  echo "password is empty, please rerun with correct password param"
  exit 1
fi

printing_the_header "Disable default NodeJS Version Module"
dnf module disable nodejs -y &>>/tmp/expense.log
echo $?

printing_the_header "Enable NodeJS module for V20"
dnf module enable nodejs:20 -y &>>/tmp/expense.log
echo $?

printing_the_header "Install NodeJS"
dnf install nodejs -y &>>/tmp/expense.log
echo $?

printing_the_header "Remove old files"
rm -rf /app &>>/tmp/expense.log
echo $?

printing_the_header "copying the service file"
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log
echo $?

printing_the_header "adding user"
useradd expense &>>/tmp/expense.log
echo $?

printing_the_header "creating a new /app folder"
mkdir /app &>>/tmp/expense.log
echo $?

printing_the_header "downloading the backend zip file"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
echo $?

printing_the_header "unzipping the downloaded zip file"
cd /app &>>/tmp/expense.log
unzip /tmp/backend.zip &>>/tmp/expense.log
echo $?

printing_the_header "npm install packages"
cd /app &>>/tmp/expense.log
npm install &>>/tmp/expense.log
echo $?

printing_the_header "daemon-reload step"
systemctl daemon-reload &>>/tmp/expense.log
echo $?

printing_the_header "starting the backend service"
systemctl enable backend &>>/tmp/expense.log
systemctl start backend &>>/tmp/expense.log
echo $?

printing_the_header "installing the mysql"
dnf install mysql -y &>>/tmp/expense.log
echo $?

printing_the_header "connecting to Database"
mysql -h 172.31.27.94 -uroot -p$db_installation_password < /app/schema/backend.sql &>>/tmp/expense.log
echo $?

printing_the_header "restarting the backend service"
systemctl restart backend &>>/tmp/expense.log
systemctl status backend &>>/tmp/expense.log
echo $?