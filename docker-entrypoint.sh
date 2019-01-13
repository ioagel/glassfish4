#!/bin/sh

getent passwd $USER_NAME > /dev/null

if [ $? -ne 0 ]; then
    adduser -h /glassfish4 -s /sbin/nologin -u $USER_ID -D $USER_NAME
    chown -R $USER_NAME:$USER_NAME /glassfish4
fi

if [ "$1" = 'asadmin' ]; then
    exec su-exec $USER_NAME "$@"
fi

exec "$@"
