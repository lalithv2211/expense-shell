printing_the_header() {
  echo $1
}

print_error_status() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[1;32m SUCCESS \e[0m"
  else
    echo -e "\e[1;31m FAILURE \e[0m"
  fi
}

log_file=/home/logs/log1.txt

# common steps
# 1. removing old files
# 3. downloading zip file
# 4. unzipping the downloaded file

app_reqs() {
  printing_the_header "removing old files"
  rm -rf ${app_dir} &>> $log_file
  if [ $? -eq 0 ]; then
    print_error_status $?
  else
    print_error_status $?
    exit 2
  fi

  printing_the_header "downloading the ${component} files"
  curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/expense-${component}-v2.zip &>> $log_file
  if [ $? -eq 0 ]; then
    print_error_status $?
  else
    print_error_status $?
    exit 2
  fi

  printing_the_header "unzipping the folder downloaded"
  cd ${app_dir} &>> $log_file
  unzip /tmp/${component}.zip &>> $log_file
  if [ $? -eq 0 ]; then
    print_error_status $?
  else
    print_error_status $?
    exit 2
  fi

}