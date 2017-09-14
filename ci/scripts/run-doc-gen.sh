#!/bin/bash
#
#
env > outputs/README-1.0.md
find .
if ! grep "** OK **" test-data/test-data-1.0.0.txt;
then
    echo "TEST OK" | tee -a outputs/README\-1.0.md
else
    echo "TEST FAILURE" | tee -a outputs/README\-1.0.md
    exit 250;
fi
