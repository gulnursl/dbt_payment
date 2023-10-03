# dbt_payments Project

This is a sample **dbt** data modeling project that is based on 3 raw sample tables: `store`, `device` and `transaction`.

## How to run the project?
The project requires **Python 3** and a running instance of **Docker**.

The `init.sh` script is provided in order to run the first setup of the environment. This script:
- Creates a virtual environment and installs required Python packages there, 
- Creates a Docker container with an empty local PostgreSQL database, 
- Creates a volume in the stame container and puts the raw data there to mimic an external stage to load the data from,
- Creates schemas and raw tables and loads the data in those,
- Compiles, runs and tests the dbt project.

To run the first setup:
- First, make sure that the raw data files (`store.csv`, `device.csv` and `transaction.csv`) are stored in the `/.data` folder.
- Then, simply call `. ./init.sh` command in a terminal opened in the project folder.

## How dbt project was structured?
This project's structure follows the [best practices](https://docs.getdbt.com/guides/best-practices/how-we-structure/1-guide-overview) defined by dbt. In summary, there are three model groups:
- **staging**: Atomic building blocks that have 1-1 relation to source data. Grouped in subfolders of source data. Models are named as `stg_source_name__model_name`. Outputs are stored in `stg` schema.
- **intermediate**: Purpose-built transformation steps that defines the relationship between tables and prepare our staging models to join into the entities we want. Grouped in subfolders of business entitites. Models are named as `int_business_entity__model_name`. Outputs are stored in `int` schema.
- **marts**: Where modular pieces are brought together into a wide, rich vision of the entities. Grouped in subfolders of business entities. Models are named as `mrt_business_entity__model_name`. Outputs are stored in `mrt` schema.

## Where to find documentation?
The project documentation can be accessed [here](https://gulnursl.github.io/dbt_payment/metadata). If it is not accessible for any reason, after running the `init.sh` script and while the container is still running, running `dbt docs generate` and `dbt docs serve` commands consecutively would also create a local instance of the documentation.

Any assumption for building the data models or assumptions for the analyses can also be found in the [documentation](https://gulnursl.github.io/dbt_payment/metadata).

## Where to find the analyses?
The analyses are stored in the `/analyses` folder. The compiled queries for each analysis can be found in the corresponding [documentation](https://gulnursl.github.io/dbt_payment/metadata) page. If the `init.sh` script is already run, the compiled queries can also be found in the `/target/compiled/dbt_payment/analyses` folder.

## How to run the queries?
Using any SQL client with PostgreSQL engine installed, after running the `init.sh` script and while the container is still running, the local database can be connected by the following credentials:
```
    host: localhost
    port: 5432
    user: db_user
    password: db_password
    database: dev
```
Then, the queries can be run locally through this connection.
