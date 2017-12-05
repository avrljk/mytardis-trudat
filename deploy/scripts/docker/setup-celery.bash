#!/bin/bash

# This script is used during development with the "docker-compose exec
# celery ..."  command to perform manually any extra setup tasks on the
# celery container after it is running.

scriptDir="$(dirname $0)"
source "$scriptDir/setup-common.bash"

addMyTardisDataCertAppSettings
