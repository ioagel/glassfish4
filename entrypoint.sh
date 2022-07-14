#!/bin/sh

# We need this for the app to be deployed when containers restarts
rm -rf /glassfish4/glassfish/domains/domain1/autodeploy/.autodeploystatus
rm -rf /glassfish4/glassfish/domains/domain1/autodeploy/bundles
rm -rf /glassfish4/glassfish/domains/domain1/autodeploy/*.war_deployed

exec "$@"