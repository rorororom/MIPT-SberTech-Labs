#!/bin/sh
set -eu
cp /key.pub /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
ssh-keygen -A

if [ -x /opt/app/start.sh ]; then
    rm -f /run/app.pid
    /opt/app/start.sh
fi
if [ -x /usr/sbin/nginx ]; then
    service nginx start
fi

exec /usr/sbin/sshd -D -e
