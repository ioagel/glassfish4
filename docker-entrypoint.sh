#!/bin/bash

if ! getent passwd "$USER_NAME" > /dev/null; then
    useradd -d /glassfish4 -M -s /usr/sbin/nologin -u "$USER_ID" "$USER_NAME"
    chown -R "$USER_NAME":"$USER_NAME" /glassfish4
fi

GF_CONFIG=/glassfish4/glassfish/domains/domain1/config
if [ ! -f "$GF_CONFIG/domain.xml" ] ; then
  cp "$GF_CONFIG"/domain.before-sed.xml "$GF_CONFIG"/domain.xml
  gosu "$USER_NAME" sed -i "s/MYSQL_PASS_PLACEHOLDER/$MYSQL_PASS/" "$GF_CONFIG"/domain.xml
fi

if [ "$1" = 'asadmin' ]; then
    exec gosu "$USER_NAME" "$@"
fi

exec "$@"
