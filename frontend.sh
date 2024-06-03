echo install nginx
dnf install nginx -y
echo $?

echo start nginx service
systemctl enable nginx
systemctl start nginx
echo $?

echo copying the configuration file
cp expense.conf /etc/nginx/default.d/expense.conf
echo $?

echo removing old files
rm -rf /usr/share/nginx/html/*
echo $?

echo downloading tthe frontend files
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip
echo $?

echo unzipping the folder downloaded
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
echo $?

echo restarting nginx
systemctl restart nginx
echo $?