FROM frictionlessdata/datapackage-pipelines

RUN apk add --update --no-cache git bash &&\
    sed -i "s/dpp serve/python3 -c 'from datapackage_pipelines.web import app; app.run(host=\"0.0.0.0\",debug=False,port=5050)'/" /dpp/docker/run.sh &&\
    pip install --upgrade pip

COPY requirements.txt /usr/src/datapackage_pipelines_ckanext/
RUN pip install --upgrade --src /usr/local/lib/python3.6/src -r /usr/src/datapackage_pipelines_ckanext/requirements.txt

COPY setup.py . /usr/src/datapackage_pipelines_ckanext/
RUN pip install --src /usr/local/lib/python3.6/src -e /usr/src/datapackage_pipelines_ckanext/

WORKDIR /pipelines

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
