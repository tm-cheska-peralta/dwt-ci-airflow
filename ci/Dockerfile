FROM python:3.10-slim

RUN apt-get update && apt-get -y install build-essential

WORKDIR /opt/airflow
COPY airflow/requirements.txt /opt/airflow/requirements.txt
RUN pip install -r requirements.txt

# Migrate only the necessary files to container
COPY airflow/src/* /opt/airflow/src/
COPY airflow/tests/* /opt/airflow/tests/
