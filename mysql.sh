source common.sh

db_installation_password=$1

printing_the_header "installing the mysql server"
dnf install mysql-server -y &>> $log_file
if [ $? -eq 0]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "starting the mysql in server"
systemctl enable mysqld &>> $log_file
systemctl start mysqld &>> $log_file
if [ $? -eq 0]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "securely installing mysql"
mysql_secure_installation --set-root-pass $db_installation_password &>> $log_file
if [ $? -eq 0]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi