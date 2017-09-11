#!/usr/bin/bash
#
#
cd appdata
find .; 
set +x ; 
APP_URL=`cat appdata*.txt | grep URL | awk -F= '{print $2}' `;
curl -vvv -k $APP_URL #| tee test-data-1.*.txt

