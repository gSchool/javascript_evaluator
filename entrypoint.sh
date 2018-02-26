#!/bin/bash
set -e

[[ ${DEBUG} == true ]] && set -x

# default behaviour is to launch postgres
if [[ "postgres" == ${1} ]]; then
  source ${PG_APP_HOME}/functions

  map_uidgid

  create_datadir
  create_certdir
  create_logdir
  create_rundir

  set_resolvconf_perms

  configure_postgresql

  echo "Starting PostgreSQL ${PG_VERSION}..."
  exec start-stop-daemon --start --chuid ${PG_USER}:${PG_USER} \
    --exec ${PG_BINDIR}/postgres -- -D ${PG_DATADIR} ${EXTRA_ARGS}
else
  /usr/bin/mongod
fi

