#!/usr/bin/env bash

VERSION_LABEL="${1}"

[ "${VERSION_LABEL}" == "" ] \
    && echo Missing version label \
    && echo current VERSION.txt = $(cat VERSION.txt) \
    && exit 1

echo "${VERSION_LABEL}" > VERSION.txt &&\
docker build -t orihoch/datapackage-pipelines-ckanext:latest datapackage_pipelines_ckanext &&\
docker tag orihoch/datapackage-pipelines-ckanext:latest orihoch/datapackage-pipelines-ckanext:v${VERSION_LABEL} &&\
python setup.py sdist &&\
twine upload dist/ckanext-datapackage_pipelines-${VERSION_LABEL}.tar.gz &&\
docker push orihoch/datapackage-pipelines-ckanext:latest &&\
docker push orihoch/datapackage-pipelines-ckanext:v${VERSION_LABEL} &&\
echo pypi: ckanext-datapackage_pipelines-${VERSION_LABEL} &&\
echo docker: orihoch/datapackage-pipelines-ckanext:latest &&\
echo docker: orihoch/datapackage-pipelines-ckanext:v${VERSION_LABEL} &&\
echo Great Success &&\
exit 0

exit 1
