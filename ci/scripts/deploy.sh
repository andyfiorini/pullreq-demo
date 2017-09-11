#!/usr/bin/bash
set -e -x

### Load env
TIMESTAMP=`date +%s`
TAIL_TIMESTAMP=`echo $TIMESTAMP | cut -c8`

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

printf "%s\n%s\n" APP_URL=$APP_URL APP_NAME=$APP_NAME  | sed 's/,//g' > outputs/appdata-1.$TAIL_TIMESTAMP-0.txt

echo "***********"
cat outputs/appdata*.txt
echo "***********"
