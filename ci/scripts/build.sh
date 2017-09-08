#!/usr/bin/env bash 
set -e

cd pull-request/
./gradlew clean assemble
echo "************************  Build ok  *******************"
echo "************************  Build ok  *******************"
FORMER_APP_NAME=`grep "\- name: " manifest.yml | awk -F: '{print $2}'` 
TIMESTAMP=`date +%s`
NEW_APP_NAME=`printf "%stest%s" $APP_NAME $TIMESTAMP ;`
cat manifest.yml | sed '/- name:/d' > tmp1
cat tmp1 | sed '/^$/d' > tmp2
head -2 manifest.yml > header
LINES=$(wc -l manifest.yml| awk '{print $1}')
let LINESm2=$((LINES))-2;
tail -$LINESm2 manifest.yml > footer
cat footer | grep -v "- name:" | grep -v "  host: " | tee end
echo "- name: $NEW_APP_NAME" >> tmp2 
echo "  host: $NEW_APP_NAME" >> tmp2 
echo "************** NEW MANIFEST *******************"
cat header tmp2 footer | tee manifest.yml
echo "***********************************************"
echo "************************  Manifest mod ok  *******************"
echo "NEW APP NAME IS: $NEW_APP_NAME"
ls -ltr manifest* && cat manifest.yml
echo "************************                   *******************"
cd -
tar cvfz outputs/git-pr-1.$TIMESTAMP.tar.gz pull-request
#ls -ltr $PWD/git-pr.tar.gz /tmp/git-pr.tar.gz

