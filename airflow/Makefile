.PHONY: dev deps test docker clean
PYTHON_VERSION := "$$(python3 --version | cut -d " " -f 2 | cut -d "." -f 1-2)"
AIRFLOW_VERSION := "$$(cat airflow.version)"
CONSTRAINT := https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt

help:
	@awk -F ':.*?## ' '/^[a-zA-Z]/ && NF==2 {printf "\033[36m  %-25s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

run: clean dev airflow_init
	poetry run airflow standalone

dev: ## Setup dev environment
	poetry env use python3.10
	poetry update
	poetry install

airflow_init:
	poetry run airflow users create \
		--role Admin \
		--username admin \
		--email admin \
		--firstname admin \
		--lastname admin \
		--password "$$AIRFLOW_ADMIN_PW"

test: ## Run tests
	poetry run pytest -v

docker: ## Build Local Docker Image
	docker compose -f docker-compose.yaml up -d --build

docker-stop: ## Stops running docker process 
	docker compose -f docker-compose.yaml down

clean: ## Remove virtual environments and docker images
	rm -rf logs
	rm webserver_config.py || true
	rm airflow.cfg || true
	rm airflow.db || true

recreate_template_dependencies:
	poetry run pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT}"
	poetry run pip freeze > requirements.txt
	cat requirements.txt | xargs -I % sh -c 'poetry add "%"'
	poetry lock

