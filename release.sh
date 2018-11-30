#!/usr/bin/env bash

VERSION_LABEL="${1}"

[ "${VERSION_LABEL}" == "" ] \
    && echo Missing version label \
    && echo current VERSION.txt = $(cat VERSION.txt) \
    && exit 1

if [ "${VERSION_LABEL}" == "--minikube" ]; then
    echo "Building Docker image for testing on Minikube"
    TIMESTAMP=`date +%s`
    eval $(minikube docker-env) &&\
    docker build -t orihoch/datapackage-pipelines-ckanext:mc${TIMESTAMP} datapackage_pipelines_ckanext &&\
    [ "$?" != "0" ] && exit 1
    echo docker: orihoch/datapackage-pipelines-ckanext:mc${TIMESTAMP}
    if [ "${2}" != "" ]; then
        echo Releasing version ${2}
        ! ./release.sh ${2} && echo failed release && exit 1
        exit 0
    else
        echo Great Success
        exit 0
    fi

else
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
fi

exit 1
