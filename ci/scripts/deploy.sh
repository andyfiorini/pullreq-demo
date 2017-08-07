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

cf push
if [ $? != 0 ];
then
    echo "Error en cf push"; 
    exit 244;
fi
