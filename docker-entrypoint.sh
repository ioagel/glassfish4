#!/bin/sh

getent passwd $USERNAME > /dev/null

if [ $? -ne 0 ]; then
    adduser -h /glassfish4 -s /sbin/nologin -u $UID -D $USERNAME
    chown -R $USERNAME:$USERNAME /glassfish4
fi

if [ "$1" = 'asadmin' ]; then
    exec su-exec $USERNAME "$@"
fi

exec "$@"
