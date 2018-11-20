curl -X PUT http://couchdb:5984/_users
curl -X PUT http://couchdb:5984/_replicator
curl -X PUT http://couchdb:5984/_global_changes
curl -X PUT http://couchdb:5984/subsea-file-store

cd /root/xgds_subsea && \
find . -path "*/migrations/*.py" -not -name "__init__.py" -delete && \
find . -path "*/migrations/*.pyc"  -delete && \
./manage.py prep && \
./manage.py prepmigrations && \
./manage.py migrate && \
exec /usr/sbin/apachectl -D FOREGROUND
tail -f /var/logs/apache2/error.log

