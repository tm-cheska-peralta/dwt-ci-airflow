#!/bin/bash

cd /aws-codepipeline

# Retrieve environment variables for postgresql conn 
export DB_USERNAME=$(aws ssm get-parameter --name "AIRFLOW_POSTGRES_USERNAME" --query "Parameter.Value" --output text)
export DB_PASSWORD=$(aws ssm get-parameter --name "AIRFLOW_POSTGRES_PASSWORD" --with-decryption --query "Parameter.Value" --output text)
export DB_NAME=$(aws ssm get-parameter --name "AIRFLOW_POSTGRES_DB_NAME" --query "Parameter.Value" --output text)
export DB_HOST=$(aws ssm get-parameter --name "AIRFLOW_POSTGRES_HOSTNAME" --query "Parameter.Value" --outputer text)
export DB_PORT=5432

# Retrieve environment variables for airflow
export AIRFLOW__CORE__FERNET_KEY=$(aws ssm get-parameter --name "AIRFLOW__CORE__FERNET_KEY" --with-decryption --query "Parameter.Value" --output text)
export AIRFLOW__WEBSERVER__SECRET_KEY=$(aws ssm get-patameter --name "AIRFLOW__WEBSERVER__SECRET_KEY" --with-decryption --query "Parameter.Value" --output text)
export AIRFLOW_USER_ADMIN_USERNAME=$(aws ssm get-parameter --name "AIRFLOW_USER_ADMIN_USERNAME" --query "Parameter.Value" --output text)
export AIRFLOW_USER_ADMIN_PASSWORD=$(aws ssm get-parameter --name "AIRFLOW_USER_ADMIN_PASSWORD" --with-decryption --query "Parameter.Value" --output text)

# Build and Run
sudo -E docker compose -f ci/docker-compose.yaml up -d --build