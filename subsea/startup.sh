#!/bin/bash

echo "*** SETTING UP COUCHDB ***"

# TODO couch takes a while to spin up and we have been unable to get this to work from this script
# ideally put some logic in to get the result from the first curl and if it fails then have a loop where we sleep
# for a certain number of seconds and repeat a certain number of times.
sleep 3

#curl -X PUT http://couchdb:5984/_users
#curl -X PUT http://couchdb:5984/_replicator
#curl -X PUT http://couchdb:5984/_global_changes
#curl -X PUT http://couchdb:5984/subsea-file-store

echo "*** DONE SETTING UP COUCHDB ***"

# TODO now the script dies somewhere here where it doesn't print stuff out, it used to work
# since the db is persistent it is not safe to blow away migrations like this if we are repeatedly running this script
cd /root/xgds_subsea && \
#find . -path "*/migrations/*.py" -not -name "__init__.py" -delete && \
#find . -path "*/migrations/*.pyc"  -delete && \
./manage.py prepmigrations && \
./manage.py migrate && \
./manage.py prepfixtures && \
./manage.py prepnpm && \
./manage.py prep && \
exec /usr/sbin/apachectl -D FOREGROUND
tail -f /var/logs/apache2/error.log

