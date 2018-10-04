import os
from datapackage_pipelines.generators import GeneratorBase, steps


class Generator(GeneratorBase):

    @classmethod
    def get_schema(cls):
        return {"$schema": "http://json-schema.org/draft-04/schema#",
                "type": "object",
                "properties": {}}


    @classmethod
    def generate_pipeline(cls, source, base):
        for pipeline_id, pipeline in source.items():
            for dependency in pipeline.get('dependencies', []):
                ckanext_pipeline = dependency.pop('ckanext-pipeline')
                if ckanext_pipeline:
                    plugin, pipeline_dependency = ckanext_pipeline.split()
                    if base == '.':
                        dependency['pipeline'] = os.path.join(base, pipeline_dependency)
                    elif base == os.path.join('.', 'ckanext-' + plugin):
                        dependency['pipeline'] = os.path.join(base, pipeline_dependency)
            yield os.path.join(base, pipeline_id), pipeline
