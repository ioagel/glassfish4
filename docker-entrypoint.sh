#!/bin/bash

getent passwd $USER_NAME > /dev/null

if [ $? -ne 0 ]; then
    useradd -d /glassfish4 -M -s /usr/sbin/nologin -u $USER_ID $USER_NAME
    chown -R $USER_NAME:$USER_NAME /glassfish4
fi

if [ "$1" = 'asadmin' ]; then
    exec gosu $USER_NAME "$@"
fi

exec "$@"
