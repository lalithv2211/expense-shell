db_installation_password=$1

echo Disable default NodeJS Version Module
dnf module disable nodejs -y &>>/tmp/expense.log
echo $?

echo Enable NodeJS module for V20
dnf module enable nodejs:20 -y &>>/tmp/expense.log
echo $?

echo Install NodeJS
dnf install nodejs -y &>>/tmp/expense.log
echo $?

echo Remove old files
rm -rf /app &>>/tmp/expense.log
echo $?

echo copying the service file
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log
echo $?

echo adding user
useradd expense &>>/tmp/expense.log
echo $?

echo creating a new /app folder
mkdir /app &>>/tmp/expense.log
echo $?

echo downloading the backend zip file
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
echo $?

echo unzipping the downloaded zip file
cd /app &>>/tmp/expense.log
unzip /tmp/backend.zip &>>/tmp/expense.log
echo $?

echo npm install packages
cd /app &>>/tmp/expense.log
npm install &>>/tmp/expense.log
echo $?

echo daemon-reload step
systemctl daemon-reload &>>/tmp/expense.log
echo $?

echo starting the backend service
systemctl enable backend &>>/tmp/expense.log
systemctl start backend &>>/tmp/expense.log
echo $?

echo installing the mysql
dnf install mysql -y &>>/tmp/expense.log
echo $?

echo connecting to Database
mysql -h 172.31.43.37 -uroot -p$db_installation_password < /app/schema/backend.sql &>>/tmp/expense.log
echo $?

echo restarting the backend service
systemctl restart backend &>>/tmp/expense.log
systemctl status backend &>>/tmp/expense.log
echo $?