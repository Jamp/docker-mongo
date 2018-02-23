#!/bin/bash
set -m

DEVELOPMENT_DB=developer
DEVELOPMENT_USER=developer
DEVELOPMENT_PASSWORD=123

### Wait for mongo deamon is ready and set user admin
STARTUP=1

while [[ STARTUP -ne 0 ]]; do
    echo "Set configuration on mongo auth, please wait..."
    sleep 5
    mongo --eval "version" > /dev/null 2>&1
    STARTUP=$?
done

mongo admin --eval "db.createUser({ user: 'admin', pwd: '123', roles: [{ role: 'userAdminAnyDatabase', db: 'admin' }]})"

echo "Admin user created!"
sleep 2

mongo admin -u admin -p 123 << EOF
use $DEVELOPMENT_DB
db.createUser({ user: '$DEVELOPMENT_USER', pwd: '$DEVELOPMENT_PASSWORD', roles: [{ role: 'dbOwner', db: '$DEVELOPMENT_DB' }]})
EOF

echo "$DEVELOPMENT_USER user created!"
sleep 2

touch /data/db/.auth_set

echo "Configuration on mongo server is ready!!!"
