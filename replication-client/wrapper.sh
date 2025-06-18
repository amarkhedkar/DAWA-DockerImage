#!/bin/bash

DATABASE_URL="postgres://$POSTGRES_USER:$POSTGRES_PASSWORD@postgres:5432/$POSTGRES_DB"
DEFAULT_SYNC_PERIOD=3600

readonly REQUIRED_ENV_VARS=(
  "POSTGRES_USER"
  "POSTGRES_PASSWORD"
  "POSTGRES_DB")

main() {
  # Wait to ensure database is ready for connections on startup.
  until PGPASSWORD=${POSTGRES_PASSWORD} psql "${DATABASE_URL}" -c '\q' > /dev/null 2>&1; do
    >&2 echo "INFO: Postgres is NOT YET READY for connections - waiting..."
    sleep 5 & wait $!
  done

  # If the below variable is set override the default.
  if [[ ! "${REPLICATOR_SYNC_PERIOD}" -eq "" ]]; then
      DEFAULT_SYNC_PERIOD="${REPLICATOR_SYNC_PERIOD}"
      echo "INFO: Will wait ${DEFAULT_SYNC_PERIOD} seconds between replication runs."
  fi

  check_env_vars_set
  cd config
  execute_replication
  daemon_mode
}

execute_replication() {
  echo "INFO: Starting replication: `date`"
  for file in `find config_*.json`
    do
      REPLICATION_CMD="dawa-replication-client replicate --database=${DATABASE_URL} --replication-config ${file}"
      ${REPLICATION_CMD}
      if [[ $? -ne 0 ]]; then
        echo "WARNING: Replication of config ${file} did not succeed!"
      fi
  done
  echo "INFO: Finished replication: `date`"
}

check_env_vars_set() {
  for required_env_var in ${REQUIRED_ENV_VARS[@]}; do
    if [[ -z "${!required_env_var}" ]]; then
      echo "Error:
            Environment variable '$required_env_var' not set.
            Make sure you have the following environment variables set: ${REQUIRED_ENV_VARS[@]} Aborting."
      exit 1
    fi
  done
}

daemon_mode() {
  echo "INFO: Entering daemon mode..."
  while true
    do
      echo "INFO: Waiting $DEFAULT_SYNC_PERIOD seconds to run next replication..."
      sleep ${DEFAULT_SYNC_PERIOD} & wait $!
      execute_replication
    done
}

trap "exit 0" SIGINT SIGTERM SIGQUIT;

main "$@"