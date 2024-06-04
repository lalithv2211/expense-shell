source common.sh

printing_the_header "install nginx"
dnf install nginx -y
print_error_status $?

printing_the_header "start nginx service"
systemctl enable nginx
systemctl start nginx
print_error_status $?

printing_the_header "copying the configuration file"
cp expense.conf /etc/nginx/default.d/expense.conf
print_error_status $?

printing_the_header "removing old files"
rm -rf /usr/share/nginx/html/*
print_error_status $?

printing_the_header "downloading tthe frontend files"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip
print_error_status $?

printing_the_header "unzipping the folder downloaded"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
print_error_status $?

printing_the_header "restarting nginx"
systemctl restart nginx
print_error_status $?