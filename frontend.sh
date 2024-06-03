source common.sh

printing_the_header "install nginx"
dnf install nginx -y
echo $?

printing_the_header "start nginx service"
systemctl enable nginx
systemctl start nginx
echo $?

printing_the_header "copying the configuration file"
cp expense.conf /etc/nginx/default.d/expense.conf
echo $?

printing_the_header "removing old files"
rm -rf /usr/share/nginx/html/*
echo $?

printing_the_header "downloading tthe frontend files"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip
echo $?

printing_the_header "unzipping the folder downloaded"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
echo $?

printing_the_header "restarting nginx"
systemctl restart nginx
echo $?