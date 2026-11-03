#!/bin/sh
set -eu

if [ "${1:-}" = restart ]; then
    start-stop-daemon --stop --oknodo --retry TERM/5 \
        --pidfile /run/app.pid --exec /usr/bin/python3
    rm -f /run/app.pid
fi

start-stop-daemon --start --oknodo --background --make-pidfile \
    --pidfile /run/app.pid --chuid app \
    --exec /usr/bin/python3 -- /opt/app/main.py
