DROP TABLE IF EXISTS backend.store;
DROP TABLE IF EXISTS backend.device;
DROP TABLE IF EXISTS backend.transaction;

CREATE TABLE IF NOT EXISTS backend.store (
    id           NUMERIC(32,0) PRIMARY KEY NOT NULL,
    name         VARCHAR(80),
    address      VARCHAR(200),
    city         VARCHAR(40),
    country      VARCHAR(40),
    created_at   TIMESTAMP,
    typology     VARCHAR(40),
    customer_id  NUMERIC(32,0) NOT NULL
);

CREATE TABLE IF NOT EXISTS backend.device (
    id           NUMERIC(32,0) PRIMARY KEY NOT NULL,
    type         NUMERIC(32,0),
    store_id     NUMERIC(32,0) NOT NULL
);

CREATE TABLE IF NOT EXISTS backend.transaction (
    id            NUMERIC(32,0) PRIMARY KEY NOT NULL,
    device_id     NUMERIC(32,0) NOT NULL,
    product_name  VARCHAR(80),
    product_sku   VARCHAR(20),
    category_name VARCHAR(20),
    amount        NUMERIC(32,2),
    status        VARCHAR(20),
    card_number   VARCHAR(30),
    cvv           VARCHAR(3),
    created_at    TIMESTAMP,
    happened_at   TIMESTAMP
);
