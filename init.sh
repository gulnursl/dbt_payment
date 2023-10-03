# Deactivate and remove the existing virtual environment (if exists)
deactivate
rm -rf "venv"

## Create new virtual environment called 'venv'
python -m venv venv

## Activate the virtual environment based on OS
if [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "darwin"* ]]; then
    # For Linux and macOS
    source venv/bin/activate
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    # For Windows (Git Bash or Cygwin)
    source venv/Scripts/activate
else
    # For Windows (PowerShell and cmd)
    venv\Scripts\activate.bat
fi

## Install required libraries
python -m pip install -r requirements.txt

## Deploy and start the Docker container
docker-compose up -d

## Initiate the database and load data
export DATABASE_URL='postgres://db_user:db_password@localhost:5432/dev'
python -u db_init/main.py

## Set dbt environment variables
export DB_USER='db_user'
export DB_PASSWORD='db_password'
export DBT_PROFILES_DIR='deploy'

## Install dbt packages
dbt deps

## Run and test dbt
dbt compile
dbt run
dbt test
