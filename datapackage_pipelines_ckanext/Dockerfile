FROM frictionlessdata/datapackage-pipelines

RUN apk add --update --no-cache git bash &&\
    sed -i "s/dpp serve/python3 -c 'from datapackage_pipelines.web import app; app.run(host=\"0.0.0.0\",debug=False,port=5050)'/" /dpp/docker/run.sh

COPY requirements.txt /usr/src/datapackage_pipelines_ckanext/
RUN pip install --upgrade pip &&\
    pip install -r /usr/src/datapackage_pipelines_ckanext/requirements.txt

COPY setup.py . /usr/src/datapackage_pipelines_ckanext/
RUN pip install -e /usr/src/datapackage_pipelines_ckanext
