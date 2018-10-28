cd /root/xgds_subsea && \
find . -path "*/migrations/*.py" -not -name "__init__.py" -delete && \
find . -path "*/migrations/*.pyc"  -delete && \
./manage.py prep && \
./manage.py prepmigrations && \
./manage.py migrate && \
exec /usr/sbin/apachectl -D FOREGROUND

