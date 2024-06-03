source common.sh

db_installation_password=$1

printing_the_header "installing the mysql server"
dnf install mysql-server -y
echo $?

printing_the_header "starting the mysql in server"
systemctl enable mysqld
systemctl start mysqld
echo $?

printing_the_header "securely installing mysql"
mysql_secure_installation --set-root-pass $db_installation_password
echo $?