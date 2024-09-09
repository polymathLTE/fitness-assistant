#!/usr/bin/bash
# setups a fresh machine

sudo apt install direnv
direnv hook bash >> ~/.bashrc
cp .envrc_template .envrc

direnv allow
pip install pipenv
pipenv install --dev

sudo apt-get install docker-compose
docker-compose up postgres
pipenv shell

cd fitness_assistant

export POSTGRES_HOST=localhost
python db_prep.py

docker-compose up postgres grafana

pipenv shell

cd fitness_assistant

export POSTGRES_HOST=localhost
python app.py
