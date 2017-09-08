#!/usr/bin/env bash 
set -e 

cd pull-request/
./gradlew clean assemble
if [ $? != 0 ];
then
  echo "BUILD CON ERROR."
  exit 254;
else 
  echo "************************  Build ok  *******************"
fi
FORMER_APP_NAME=`grep "\- name: " manifest.yml | awk -F: '{print $2}'` 
TIMESTAMP=`date +%s`
NEW_APP_NAME=`printf "%stest%s" $APP_NAME $TIMESTAMP ;`
echo "************************  Manifest mod ok  *******************"
echo "NEW APP NAME IS: $NEW_APP_NAME"
echo "************************                   *******************"
cat manifest.yml | sed '/- name:/d' > tmp1
cat tmp1 | sed '/^$/d' > tmp2
head -2 manifest.yml > header
LINES=$(wc -l manifest.yml| awk '{print $1}')
let LINESm2=$((LINES))-2;
tail -$LINESm2 manifest.yml > footer
cat footer | grep -v "\- name:" | grep -v "host:" > end
echo "- name: $NEW_APP_NAME" > tmp2 
echo "  host: $NEW_APP_NAME" >> tmp2 
echo "************** NEW MANIFEST *******************"
cat header tmp2 end | tee manifest.yml
echo "***********************************************"
cd -
tar cvfz outputs/git-pr-1.$TIMESTAMP.tar.gz pull-request

