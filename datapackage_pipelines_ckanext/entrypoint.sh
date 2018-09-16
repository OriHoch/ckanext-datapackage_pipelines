#!/usr/bin/env sh

cd /usr/src/datapackage_pipelines_ckanext

for FILE in `find /pipelines -name 'requirements.txt'`; do
    ! pip install --upgrade --src /usr/local/lib/python3.6/src -r $FILE \
        && echo failed to install pip requirements $FILE && exit 1
done

cd /pipelines

exec /dpp/docker/run.sh "$@"
