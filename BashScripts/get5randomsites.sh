#!/bin/bash

#check if "jq" installed
status="$(dpkg-query -W --showformat='${db:Status-Status}' "jq" 2>&1)"
if [ ! $? = 0 ] || [ ! "$status" = installed ]; then
  sudo apt install jq
  echo "jq package has been installed."
fi

#getting sites list form url
json=$(curl -s "https://www.randomlists.com/data/websites.json" | jq ".data" | jq -r ".[]")

#output to a file "newfile.txt"
shuf -e -n5 $json > newfile.txt
echo "Output file newfile.txt has been generated."
