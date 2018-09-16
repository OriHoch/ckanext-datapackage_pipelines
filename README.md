# ckanext-datapackage_pipelines

![Docker: orihoch/datapackage-pipelines-ckan](https://img.shields.io/badge/Docker-orihoch/datapackage--pipelines--ckanext-darkgreen.svg)

Integrate [datapackage-pipelines](https://github.com/frictionlessdata/datapackage-pipelines) with CKAN

Minimal supported CKAN version: 2.8.1

## Installation

### Install the plugin

* Create a directory to hold the pipelines, ckan pipeline extensions write to that directory
  * `sudo mkdir -p /var/ckan/pipelines`
  * `sudo chown -R $USER:$GROUP /var/ckan`
  * This directory should be shared between the pipelines server and CKAN
* Activate your CKAN virtual environment
* Install the ckanext-datapackage_pipelines package into your virtual environment:
  * `pip install ckanext-datapackage_pipelines`
* Add `datapackage_pipelines` to the `ckan.plugins` setting in your CKAN
* Restart CKAN.

### Start the datapackage-pipelines server

The following command starts a local pipelines server for development on the host network

CKAN_API_KEY should be a CKAN user's api key which has sysadmin privileges

If you are running the CKAN Redis server on the same host, you should modify the port to prevent collision
with the pipelines server Redis which runs on port 6379.

The pipelines server runs on port 5050.

```
docker run -v /var/ckan/pipelines:/pipelines:rw \
           -e CKAN_API_KEY=*** \
           -e CKAN_URL=http://localhost:5000 \
           --net=host \
           orihoch/datapackage-pipelines-ckanext server
```

## Usage

Pipelines dashboard is available publically at http://your-ckan-url/pipelines

CKAN plugins can use the pipelines server by implementing the `IDatapackagePipelines` interface.

`register_pipelines` method returns the pipelines name (usually the name of the plugin) and directory to get the plugin's
pipelines from. When CKAN is restarted the pipelines are copied by default to /var/ckan/pipelines - this directory should be
shared between CKAN and the pipelines server. If the plugin pipelines directories contains a `requirements.txt` it will be
installed on restart of the pipelines server.

## Configuration

Following are the supported configurations and default values

```
ckanext.datapackage_pipelines.directory = /var/ckan/pipelines
ckanext.datapackage_pipelines.dashboard_url = http://localhost:5050
```

## Updating the package on PYPI

Update the version in `VERSION.txt`, then build and upload:

```
python setup.py sdist &&\
twine upload dist/ckanext-datapackage_pipelines-$(cat VERSION.txt).tar.gz
```

ckanext-datapackage_pipelines should be availabe on PyPI as https://pypi.python.org/pypi/ckanext-datapackage_pipelines.
