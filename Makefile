.PHONY: install test lint run build up down

install:
	pip install -r requirements-dev.txt

test:
	pytest -v

lint:
	flake8 app tests --max-line-length=100

run:
	python app/main.py

build:
	docker build -t devops-cicd-pipeline:latest .

up:
	docker compose up -d --build

down:
	docker compose down
