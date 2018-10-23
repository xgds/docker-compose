cd /root/xgds_subsea && \
    ./manage.py prep && \
    ./manage.py prepnpm
    ./manage.py prepmigrations && \
    ./manage.py migrate && \
    exec /usr/sbin/apachectl -D FOREGROUND
