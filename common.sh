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

log_file = /home/logs/log1.txt