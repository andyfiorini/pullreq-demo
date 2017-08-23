#!/usr/bin/env bash
#set -ex

cd git-pr/
./gradlew clean assemble
echo "************************  Build ok  *******************"
ls -ltr manifest* && cat manifest.yml
echo "************************  Build ok  *******************"
cd -
tar cvfz outputs/git-pr.tar.gz git-pr
#ls -ltr $PWD/git-pr.tar.gz /tmp/git-pr.tar.gz

