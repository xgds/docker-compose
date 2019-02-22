#!/bin/bash

echo "*** RESUMING WITH EXISTING VOLUMES ***"

echo "*** STARTING UP PYRAPTORD ***"
/etc/init.d/pyraptord start
echo "*** DONE STARTING UP PYRAPTORD ***"

echo "*** CLEAN OUT STALE APACHE PID FILES ***"
# clean out the apache pid in case we had an ugly death before
rm -f /var/run/apache2/apache2.pid
rm -f /var/run/apache2/.sock

echo "*** STARTING APACHE ***"
exec /usr/sbin/apachectl -D FOREGROUND
