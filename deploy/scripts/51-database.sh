#!/usr/bin/env bash
set -eux
cd /home/app/webapp

until bundle exec ruby -e "
  require 'pg'

  PG.connect(
    dbname: ENV['DB_NAME'],
    host:'postgres',
    user: 'postgres'
  )
  " &>/dev/null 2>&1
do
    echo "Development DB doesn't exist yet, setting it up now..."
    bundle exec rake db:drop db:create db:migrate
done
