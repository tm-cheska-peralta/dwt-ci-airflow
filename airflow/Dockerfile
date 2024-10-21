FROM python:3.10-slim

RUN apt-get update && apt-get -y install build-essential

WORKDIR /opt/airflow
COPY requirements.txt /opt/airflow/requirements.txt
RUN pip install -r requirements.txt

# Migrate only the necessary files to container
COPY src/* /opt/airflow/src/
