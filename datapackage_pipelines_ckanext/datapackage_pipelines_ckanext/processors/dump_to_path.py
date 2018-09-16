from datapackage_pipelines.lib.dump.to_path import PathDumper
from datapackage_pipelines_ckanext import helpers
from os import path


class CkanextPathDumper(PathDumper):

    def initialize(self, params):
        config = helpers.get_plugin_configuration(params.pop('plugin'))
        data_path = config['data_path']
        params['out-path'] = path.join(data_path, params.get('out-path', '.'))
        super(CkanextPathDumper, self).initialize(params)


if __name__ == '__main__':
    CkanextPathDumper()()
