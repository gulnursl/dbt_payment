COPY backend.store 
FROM '/docker-entrypoint-initdb.d/store.csv' 
DELIMITER ','
CSV 
HEADER;

COPY backend.device 
FROM '/docker-entrypoint-initdb.d/device.csv' 
DELIMITER ','
CSV 
HEADER;

COPY backend.transaction 
FROM '/docker-entrypoint-initdb.d/transaction.csv' 
DELIMITER ','
CSV 
HEADER;
