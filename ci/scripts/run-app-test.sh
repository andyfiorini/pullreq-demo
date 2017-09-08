#!/usr/bin/bash
#
#
cd app-data
find .; 
set +x ; 
APP_URL=$(cat app_data*.txt | grep URL | awk -F= "{print $2}") 
curl -vvv -k $APP_URL
