#!usr/bin/env bash
set -e -x

### Load env
cd git-pr
if [ $? != 0 ];
then
    echo "Error en cd";
    exit 243;
fi


yes admin | cf login -a https://api.apps.64.78.155.215.nip.io -o system --skip-ssl-validation
if [ $? != 0 ];
then
    echo "Error en cf dev target";
    exit 245;
fi

cf push | tee push.log
if [ $? != 0 ];
then
    echo "Error en cf push"; 
    exit 244;
fi


APP_URL=`cat push.log | grep "urls: " | awk '{print $2}' `
APP_NAME=`cat push.log | grep "Starting app " | awk '{print $3}' `

echo "APP_URL=$APP_URL\nAPP_NAME=$APP_NAME\n" > app_data_$APP_NAME.txt
