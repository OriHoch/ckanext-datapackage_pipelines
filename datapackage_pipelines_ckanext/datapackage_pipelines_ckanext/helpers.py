from os import environ
import requests


def get_plugin_configuration(plugin_name):
    CKAN_API_KEY = environ.get('CKAN_API_KEY')
    CKAN_URL = environ.get('CKAN_URL')
    assert CKAN_API_KEY and CKAN_URL
    url = CKAN_URL + '/pipelines/config/' + plugin_name
    return requests.get(url, headers={'Authorization': CKAN_API_KEY}).json()
