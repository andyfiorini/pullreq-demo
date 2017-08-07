#!/usr/bin/env bash
set -ex

cd git-pr/
./gradlew clean assemble
cd -

