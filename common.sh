printing_the_header() {
  echo $1
}

print_error_status() {
  if [ $1 -eq 0 ]; then
    echo "SUCCESS"
  else
    echo "FAILURE"
  fi
}