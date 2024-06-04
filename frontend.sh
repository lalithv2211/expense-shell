source common.sh

printing_the_header "install nginx"
dnf install nginx -y &>> $log_file
if [ $? -eq 0 ]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi


printing_the_header "start nginx service"
systemctl enable nginx &>> $log_file
systemctl start nginx &>> $log_file
if [ $? -eq 0 ]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "copying the configuration file"
cp expense.conf /etc/nginx/default.d/expense.conf &>> $log_file
if [ $? -eq 0 ]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "removing old files"
rm -rf /usr/share/nginx/html/* &>> $log_file
if [ $? -eq 0 ]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "downloading tthe frontend files"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>> $log_file
if [ $? -eq 0 ]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "unzipping the folder downloaded"
cd /usr/share/nginx/html &>> $log_file
unzip /tmp/frontend.zip &>> $log_file
if [ $? -eq 0 ]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi

printing_the_header "restarting nginx"
systemctl restart nginx &>> $log_file
if [ $? -eq 0 ]; then
  print_error_status $?
else
  print_error_status $?
  exit 2
fi