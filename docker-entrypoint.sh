#!/bin/bash

if ! getent passwd "$USER_NAME" > /dev/null; then
    useradd -d /glassfish4 -M -s /usr/sbin/nologin -u "$USER_ID" "$USER_NAME"
    chown -R "$USER_NAME":"$USER_NAME" /glassfish4
fi

GF_CONFIG=/glassfish4/glassfish/domains/domain1/config
if [ ! -f "$GF_CONFIG/domain.xml.configured" ] ; then
  gosu "$USER_NAME" cp "$GF_CONFIG"/domain.tpl.xml "$GF_CONFIG"/domain.xml
  gosu "$USER_NAME" sed -i "s/MYSQL_PASS/$MYSQL_PASS/" "$GF_CONFIG"/domain.xml
  gosu "$USER_NAME" sed -i "s/MYSQL_HOST/$MYSQL_HOST/" "$GF_CONFIG"/domain.xml
  gosu "$USER_NAME" sed -i "s/MYSQL_PORT/$MYSQL_PORT/" "$GF_CONFIG"/domain.xml
  gosu "$USER_NAME" sed -i "s/MYSQL_DB/$MYSQL_DB/" "$GF_CONFIG"/domain.xml
  gosu "$USER_NAME" sed -i "s/MYSQL_USER/$MYSQL_USER/" "$GF_CONFIG"/domain.xml
  gosu "$USER_NAME" sed -i "s/APP_INSIGHTS_AGENT_VER/$APP_INSIGHTS_AGENT_VER/g" "$GF_CONFIG"/domain.xml
  gosu "$USER_NAME" touch "$GF_CONFIG"/domain.xml.configured
fi

if [ "$1" = 'asadmin' ]; then
    exec gosu "$USER_NAME" "$@"
fi

exec "$@"
