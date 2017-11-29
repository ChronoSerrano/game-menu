#!/usr/bin/env bash
set -eux
# Perform necessary work to prepare the new container to run your application
## This will generally be tasks like vendor package installs, filesystem cleanup, etc

echo "Installing gems into vendor/bundle..."
cd /home/app/webapp
bundle install --jobs=4 --path=vendor/bundle

rm -f pids/* tmp/pids/*
