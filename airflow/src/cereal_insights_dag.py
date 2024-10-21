from datetime import datetime, timedelta
import csv
import requests

from airflow import DAG
from airflow.decorators import task


with DAG(
    "cereal_insights",
    description="A simple DAG that ingests nutritional information about cereals.",
    schedule_interval=timedelta(days=1),
    start_date=datetime(2024,1,1),
    catchup=False,
) as dag:
    @task
    def retrieve_cereals():
        response = requests.get("https://docs.dagster.io/assets/cereal.csv")
        lines = response.text.split("\n")
        cereals = [row for row in csv.DictReader(lines)]

        return cereals
    

    @task
    def find_highest_calorie_cereal(cereals):
        sorted_cereals = list(sorted(cereals, key=lambda cereal: cereal["calories"]))
        return sorted_cereals[-1]["name"]
    

    @task
    def find_highest_protein_cereal(cereals):
        sorted_cereals = list(sorted(cereals, key=lambda cereal: cereal["protein"]))
        return sorted_cereals[-1]["name"]
    

    @task
    def log_results(most_calories, most_protein):
        print(f"Most caloric cereal: {most_calories}")
        print(f"Most protein-rich cereal: {most_protein}")

    
    # Define task dependencies
    cereals = retrieve_cereals()
    most_calories = find_highest_calorie_cereal(cereals)
    most_protein = find_highest_protein_cereal(cereals)
    log_results(most_calories, most_protein)
