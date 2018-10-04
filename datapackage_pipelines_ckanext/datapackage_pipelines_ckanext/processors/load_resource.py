from datapackage_pipelines.lib.load_resource import ResourceLoader
import os, logging
from datapackage_pipelines_ckanext.helpers import get_plugin_configuration


class CkanextLoader(ResourceLoader):

    def __init__(self, **kwargs):
        super(CkanextLoader, self).__init__()
        self.parameters.update(**kwargs)
        path = self.parameters.pop('path')
        plugin = self.parameters.pop('plugin')
        assert path, plugin
        config = get_plugin_configuration(plugin)
        self.parameters['url'] = os.path.join(config['data_path'], path)


if __name__ == '__main__':
    CkanextLoader()()
