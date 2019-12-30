#!/bin/bash

GF_CONFIG=/glassfish4/glassfish/domains/domain1/config
if [ ! -f "$GF_CONFIG/domain.xml.configured" ] ; then
  cp "$GF_CONFIG"/domain.tpl.xml "$GF_CONFIG"/domain.xml
  sed -i "s/MYSQL_PASS/$MYSQL_PASS/" "$GF_CONFIG"/domain.xml
  sed -i "s/MYSQL_HOST/$MYSQL_HOST/" "$GF_CONFIG"/domain.xml
  sed -i "s/MYSQL_PORT/$MYSQL_PORT/" "$GF_CONFIG"/domain.xml
  sed -i "s/MYSQL_DB/$MYSQL_DB/" "$GF_CONFIG"/domain.xml
  sed -i "s/MYSQL_USER/$MYSQL_USER/" "$GF_CONFIG"/domain.xml
  sed -i "s/APP_INSIGHTS_AGENT_VER/$APP_INSIGHTS_AGENT_VER/g" "$GF_CONFIG"/domain.xml
  touch "$GF_CONFIG"/domain.xml.configured
fi

exec "$@"
