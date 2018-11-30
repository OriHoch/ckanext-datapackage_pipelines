#!/usr/bin/env sh

cd /usr/src/datapackage_pipelines_ckanext

for FILE in `find /pipelines -name 'requirements.txt'`; do
    ! pip install --upgrade --src /usr/local/lib/python3.6/src -r $FILE \
        && echo failed to install pip requirements $FILE && exit 1
done

cd /pipelines

if [ "${MANUAL_PIPELINES}" != "" ]; then
    (
        until [ `redis-cli ping | grep -c PONG` = 1 ]; do echo "Waiting 1s for Redis to load"; sleep 1; done
        dpp init
    ) &
    redis-server /etc/redis.conf --dir /var/redis
else
    exec /dpp/docker/run.sh "$@"
fi
