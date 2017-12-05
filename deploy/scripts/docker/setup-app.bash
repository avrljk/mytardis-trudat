#!/bin/bash

# This script is used during development with the "docker-compose exec
# app ..."  command to perform manually any extra setup tasks on the
# app container after it is running.

scriptDir="$(dirname $0)"
source "$scriptDir/setup-common.bash"

baseDir='/srv/mytardis'
if cd "$baseDir"
then
    :
else
    echo "Can't access MyTardis base directory: $baseDir" 1>&2
    exit 1
fi

# Create the MyTardis database admin.
#
# The recommended "python mytardis.py createmysuperuser" command
# forces a noecho read from stdin for the password, preventing <<EOF
# redirection.  Instead, use Python code to do the same thing.
#
python manage.py shell <<EOF
from django.contrib.auth.models import User
User.objects.filter(email='jonathan.knispel@uwa.edu.au').delete()
User.objects.create_superuser('root', 'jonathan.knispel@uwa.edu.au', 'root@Port8K')
EOF

addMyTardisDataCertAppSettings
