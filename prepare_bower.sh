#!/usr/bin/env bash

echo "Prepare Bower"

if [ -z "$CIRCLECI" ]; then
  rm -rf ./vendor/assets/bower_components
fi

./node_modules/bower/bin/bower install
