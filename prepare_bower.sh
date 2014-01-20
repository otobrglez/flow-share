#!/usr/bin/env bash

echo "Prepare Bower"

if [ -z "$CIRCLECI" ]; then

  if [ -d vendor/assets/bower_components ]; then
    echo "Exists remove..."
    rm -rf vendor/assets/bower_components
  fi
fi

node_modules/bower/bin/bower install
