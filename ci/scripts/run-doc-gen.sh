#!/bin/bash
#
#
env > outputs/README-1.0.md
if grep "** OK **" test-data/*.txt;
then
    echo "TEST OK" | tee -a outputs/README\-1.0.md
else
    echo "TEST FAILURE" | tee -a outputs/README\-1.0.md
    exit 250;
fi
