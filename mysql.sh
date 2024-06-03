echo installing the mysql server
dnf install mysql-server -y
echo $?

echo starting the mysql in server
systemctl enable mysqld
systemctl start mysqld
echo $?

echo securely installing mysql
mysql_secure_installation --set-root-pass ExpenseApp@1
echo $?