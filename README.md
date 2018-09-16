# ckanext-datapackage_pipelines

Integrate datapackage-pipelines with CKAN

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

```
docker run -v /var/ckan/pipelines:/pipelines:rw \
           -e CKAN_API_KEY=*** \
           -e CKAN_URL=http://localhost:5050 \
           --net=host \
           orihoch/datapackage-pipelines-ckanext server
```

## Configuration

Following are the supported configurations and default values

```
ckanext.datapackage_pipelines.dashboard_url = http://localhost:5050
ckanext.datapackage_pipelines.directory = /var/ckan/pipelines
```
