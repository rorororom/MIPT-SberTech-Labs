#!/bin/sh
set -eu

start-stop-daemon --stop --oknodo --retry TERM/5 \
    --pidfile /run/app.pid --exec /usr/bin/python3
rm -f /run/app.pid

start-stop-daemon --start --background --make-pidfile \
    --pidfile /run/app.pid --chuid app \
    --exec /usr/bin/python3 -- /opt/app/main.py
