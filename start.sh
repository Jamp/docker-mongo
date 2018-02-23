#!/bin/bash
set -m

### Start mongo server
echo 'Initializate Mongo Server'
mongod --bind_ip_all --auth &

### Check user admin is set
if [ ! -d /data/db/.auth_set ]; then
    /create-user.sh
fi

fg
