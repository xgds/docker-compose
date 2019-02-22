#!/bin/bash

if [ -e /usr/local/.setup-complete ]
then
    echo "*** STARTUP EXISTING xGDS INSTANCE ***"
    ./resume.sh
else
    echo "*** INITIALIZE NEW xGDS INSTANCE ***"
    ./setup-new.sh
fi
