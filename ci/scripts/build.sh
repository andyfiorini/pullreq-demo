#!/usr/bin/env bash 
set -e

cd git-pr/
./gradlew clean assemble
echo "************************  Build ok  *******************"
echo "************************  Build ok  *******************"
FORMER_APP_NAME=`grep "\- name: " manifest.yml | awk -F: '{print $2}'` 
TIMESTAMP=`date +%s`
NEW_APP_NAME=`printf "%stest%s", $APP_NAME, $TIMESTAMP ;`
cat manifest.yml | sed '/\- name:/d' > tmp1
cat manifest.yml | sed '/^$/d' > tmp2
echo "- name: $NEW_APP_NAME" >> tmp2 
mv tmp2 manifest.yml
echo "************************  Manifest mod ok  *******************"
echo "NEW APP NAME IS: $NEW_APP_NAME"
ls -ltr manifest* && cat manifest.yml
echo "************************                   *******************"
cd -
tar cvfz outputs/git-pr-1.0.0.tar.gz git-pr
#ls -ltr $PWD/git-pr.tar.gz /tmp/git-pr.tar.gz

