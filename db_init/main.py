import psycopg2 as ps
import logging
import os
import time

log = logging.getLogger()

db_url = os.getenv("DATABASE_URL")

def is_db_ready():
    try:
        conn = ps.connect(db_url)
        conn.close()
        return True
    except ps.OperationalError as e:
        log.warning(e)
        return False

max_retries = 10
retry_interval = 2
retry_count = 0

while retry_count < max_retries:
    if is_db_ready():
        break
    else:
        time.sleep(retry_interval)
        retry_count += 1
else:
    log.error("Maximum retries is reached.")
    exit()

try:
    conn = ps.connect(db_url)
    cursor = conn.cursor()

    with open("./db_init/create_schemas.sql", "r") as f:
        query = f.read()
        cursor.execute(query)
    conn.commit()
    log.info("Schemas are created.")

    with open("./db_init/create_tables.sql", "r") as f:
        query = f.read()
        cursor.execute(query)
    conn.commit()
    log.info("Tables are created.")

    with open("./db_init/copy_data.sql", "r") as f:
        query = f.read()
        cursor.execute(query)
    conn.commit()
    log.info("Data is copied.")
    
    conn.commit()

except Exception as e:
    log.error(e)


finally:
    cursor.close()
    conn.close()
