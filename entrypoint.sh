#!/bin/sh

# We need this for the app to be deployed properly when container restarts
autodeploy_dir="/glassfish4/glassfish/domains/domain1/autodeploy"
rm -rf $autodeploy_dir/.autodeploystatus
rm -rf $autodeploy_dir/bundles
rm -rf $autodeploy_dir/*.war_deployed

exec "$@"