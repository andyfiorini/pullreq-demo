#!/usr/bin/bash
set -e -x

### Load env

/usr/bin/tar xvfz release_tar/git-pr-1.*.tar.gz
[ $? != 0 ] && (echo "tar... $?" && exit 255);
cd pull-request 
[ $? != 0 ] && (echo "wrong chdir... $?" && exit 254);
set +x
cf login -a $cfapi -u $cfcred -p $cfsecret --skip-ssl-validation -o $cforg -s $cfspace 
[ $? != 0 ] && (echo "cf login... $?" && exit 253);
set -x
cf push $appname -f $appmanname | tee push.log ; 
[ $? != 0 ] && (echo "cf push... $?" && exit 252);
export APP_URL=$(cat push.log | grep "urls: " | awk '{print $2}')
export APP_NAME=$(cat push.log | grep "Starting app " | awk '{print $3}')

cd -

echo "APP_URL=$APP_URL\nAPP_NAME=$APP_NAME\n" > outputs/app_data_$APP_NAME.txt
