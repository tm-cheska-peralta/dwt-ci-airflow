.PHONY: help
.DEFAULT_GOAL := help
-include .env
SHELL=/bin/bash

define DAGSTER_TEMPLATE_HEADER
"#-------------------------dwt-dagster-template-------------------------"
endef

define AIRFLOW_TEMPLATE_HEADER
"#-------------------------dwt-airflow-template-------------------------"
endef

define TERRAFORM_TEMPLATE_HEADER
"#------------------------dwt-terraform-template------------------------"
endef

define CI_TEMPLATE_HEADER
"#----------------------------dwt-ci-template---------------------------"
endef

define CI_TERRAFORM_TEMPLATE_HEADER
"# Cloud Build"
endef

help:
	@awk -F ':.*?## ' '/^[a-zA-Z]/ && NF==2 {printf "\033[36m  %-25s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

## Data Orchestrators
airflow:  ## Prepare a templatized setup for Airflow
	mkdir airflow
	git clone --depth=1 git@github.com:thinkingmachines/dwt-airflow-template.git airflow
ifdef add_dag_builder
	echo "Including DAG Builder"
else
	echo "Excluding DAG Builder..."
	rm -rf airflow/src/builder/
endif
	echo ${AIRFLOW_TEMPLATE_HEADER} | cat - airflow/.envrc.example >> .envrc.example
	rm -rf airflow/{.git,.gitignore,README.md,.github}

dagster:  ## Prepare a templatized setup for Dagster
	mkdir dagster
	git clone --depth=1 git@github.com:thinkingmachines/dwt-dagster-template.git dagster
	echo ${DAGSTER_TEMPLATE_HEADER} | cat - dagster/.envrc.example >> .envrc.example
	rm -rf dagster/{.git,.gitignore,README.md,.github,.envrc.example}

## Infrastructure as code
gcp-terraform: ## Prepare a templatized setup for Terraform (GCP)
	git clone --depth=1 git@github.com:thinkingmachines/dwt-terraform-template.git terraform-temp
	mv terraform-temp/google-cloud/terraform/ .
	mv terraform-temp/google-cloud/terraform.mk .
	echo "${TERRAFORM_TEMPLATE_HEADER}(gcp)" | cat - terraform-temp/google-cloud/.envrc.example >> .envrc.example
	rm -rf terraform-temp

aws-terraform: ## Prepare a templatized setup for Terraform (AWS)
	git clone --depth=1 git@github.com:thinkingmachines/dwt-terraform-template.git terraform-temp
	mv terraform-temp/aws/terraform/ .
	mv terraform-temp/aws/aws-policies/ .
	mv terraform-temp/aws/terraform.mk .
	echo "${TERRAFORM_TEMPLATE_HEADER}(aws)" | cat - terraform-temp/aws/.envrc.example >> .envrc.example
	rm -rf terraform-temp

## CI/CD
cloudbuild: ## Integrate GCP Cloud Build with Airflow/Dagster project
	git clone --depth=1 git@github.com:thinkingmachines/dwt-ci-template.git ci_temp
	cp -R ci_temp/cloudbuild/ci/${orchestrator} ci/
	cp -R ci_temp/cloudbuild/${cloud-platform}/${orchestrator} ci/
	cp ci_temp/cloudbuild/${cloud-platform}/ci.mk ci.mk
	cp ci_temp/cloudbuild/${cloud-platform}/terraform/cloudbuild.tf terraform/staging/cloudbuild.tf
	cp ci_temp/cloudbuild/${cloud-platform}/terraform/cloudbuild.tf terraform/production/cloudbuild.tf
## Staging
	echo ${CI_TERRAFORM_TEMPLATE_HEADER} | cat - ci_temp/cloudbuild/${cloud-platform}/terraform/variables.tf >> terraform/staging/variables.tf
	echo ${CI_TERRAFORM_TEMPLATE_HEADER} | cat - ci_temp/cloudbuild/${cloud-platform}/terraform/terraform.tfvars.sample >> terraform/staging/terraform.tfvars.sample
## Production
	echo ${CI_TERRAFORM_TEMPLATE_HEADER} | cat - ci_temp/cloudbuild/${cloud-platform}/terraform/variables.tf >> terraform/production/variables.tf
	echo ${CI_TERRAFORM_TEMPLATE_HEADER} | cat - ci_temp/cloudbuild/${cloud-platform}/terraform/terraform.tfvars.sample >> terraform/production/terraform.tfvars.sample
## Continue
	echo "${CI_TEMPLATE_HEADER}(cloudbuild)" | cat - ci_temp/cloudbuild/${cloud-platform}/.envrc.example >> .envrc.example
	rm -rf ci_temp

codepipeline: ## Integrate AWS CodePipeline with Dagster project
	git clone -b feat/45-add-airflow-support-to-codepipeline --single-branch --depth=1 git@github.com:thinkingmachines/dwt-ci-template.git ci_temp
	cp -R ci_temp/codepipeline/ci/${orchestrator} ci/
	cp -R ci_temp/codepipeline/scripts/${orchestrator} scripts/
	cp ci_temp/codepipeline/${cloud-platform}/${orchestrator}/appspec.yml appspec.yml
	cp -R ci_temp/codepipeline/${cloud-platform}/terraform/modules/codedeploy terraform/modules/
	cp -R ci_temp/codepipeline/${cloud-platform}/terraform/modules/codepipeline terraform/modules/
## Staging
	cp ci_temp/codepipeline/${cloud-platform}/terraform/codepipeline.tf terraform/staging/codepipeline.tf
	echo ${CI_TERRAFORM_TEMPLATE_HEADER} | cat - ci_temp/codepipeline/${cloud-platform}/terraform/variables.tf >> terraform/staging/variables.tf
	echo ${CI_TERRAFORM_TEMPLATE_HEADER} | cat - ci_temp/codepipeline/${cloud-platform}/terraform/terraform.tfvars.sample >> terraform/staging/terraform.tfvars.sample
## Production
	cp ci_temp/codepipeline/${cloud-platform}/terraform/codepipeline.tf terraform/production/codepipeline.tf
	echo ${CI_TERRAFORM_TEMPLATE_HEADER} | cat - ci_temp/codepipeline/${cloud-platform}/terraform/variables.tf >> terraform/production/variables.tf
	echo ${CI_TERRAFORM_TEMPLATE_HEADER} | cat - ci_temp/codepipeline/${cloud-platform}/terraform/terraform.tfvars.sample >> terraform/production/terraform.tfvars.sample
## Continue
	rm -rf ci_temp

## Documentation
readme-template: ## Replaces default README.md with templated file
	git clone --depth=1 git@github.com:thinkingmachines/github-starter.git starter-temp
	cp -R starter-temp/template/docs/ docs/
	cp starter-temp/template/mkdocs.yml mkdocs.yml
	mv starter-temp/.github/pull_request_template.md .github/pull_request_template.md 
	rm -rf starter-temp
	rm README.md

## Data Transformation
dbt: ## Prepare a templatized setup for dbt
	git clone --depth=1 git@github.com:thinkingmachines/dbt-starter.git dbt
	rm -rf dbt/{pull_request_template.md,README.md,.gitignore,.git}
