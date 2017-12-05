#!/bin/bash

# This script is used during development to perform manually any extra
# setup tasks on the docker containers after they are running.

echo "setting up app container..."
if docker-compose exec app \
    /bin/bash /srv/mytardis/jk-config-trudat/setup-app.bash
then
    echo "app setup OK"
else
    s=$?
    echo "error setting up app container" 1>&2
    exit "$s"
fi

echo "setting up celery container..."
if docker-compose exec celery \
    /bin/bash /srv/mytardis/jk-config-trudat/setup-celery.bash
then
    echo "celery setup OK"
else
    s=$?
    echo "error setting up celery container" 1>&2
    exit "$s"
fi

echo "done"
