
ACTION="$@"

# BEGIN FUNCTIONS

# All preparation steps needed for a deployment artifact should be contained in this function
## This would generally be tasks like bundle installs, asset building tags, and so on
function prepare_for_deployment() {
  bundle install --local --jobs=4 --deployment
}

## LOCAL ENVIRONMENTS ONLY

# Wait to start application until all backend services this service requires are available
function check_dependencies() {
  local SVCS="${MEMCACHED_HOST}/${MEMCACHED_PORT} ${MYSQL_HOST}/${MYSQL_PORT}"
  for i in ${SVCS}; do
    until cat < /dev/null > /dev/tcp/"$i" &>/dev/null 2>&1; do
      echo "$i not yet available, sleeping 5 seconds..."
      sleep 5
    done
  done
}
