#!/usr/bin/env bash
set -ex

cd git-pr/
./gradlew clean assemble
echo "************************  Build ok  *******************"
ls -ltr manifest* && cat manifest.yml
echo "************************  Build ok  *******************"
cd -

