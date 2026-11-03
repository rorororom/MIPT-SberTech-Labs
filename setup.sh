#!/bin/sh
set -eu
cd "$(dirname "$0")"

mkdir -p .ssh
chmod 700 .ssh
if [ ! -f .ssh/id_ed25519 ]; then
    ssh-keygen -q -t ed25519 -N '' -f .ssh/id_ed25519
fi

tar -czf HW_3/app.tar.gz -C HW_3/app main.py start.sh
