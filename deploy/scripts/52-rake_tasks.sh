#!/usr/bin/env bash
set -eux
cd /home/app/webapp

# List rake tasks here
bundle exec rake app:db:load:collection
