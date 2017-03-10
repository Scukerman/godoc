#!/bin/sh

set -e

APP_DIR=/go/src/github.com/golang/gddo/gddo-server
APP_YAML=$APP_DIR/app.yaml

if [ -e $APP_YAML.bak ]; then
	cp -f $APP_YAML.bak $APP_YAML
else
	cp $APP_YAML $APP_YAML.bak
fi

echo 'env_variables:' >> $APP_YAML
env | sed -E 's/^(.*?)=(.*)$/  \1: "\2"/' >> $APP_YAML

/google-cloud-sdk/bin/dev_appserver.py --host 0.0.0.0 $APP_DIR
