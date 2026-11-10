CREATE DATABASE brightmart;
SELECT current_database();

CREATE TABLE customers(
customer_id INTEGER PRIMARY KEY generated always as identity,
first_name VARCHAR (50),
last_name VARCHAR(50),
email VARCHAR(150),
phone VARCHAR(20),
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products(
product_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY ,
product_name VARCHAR(100) NOT NULL,
description TEXT,
price NUMERIC (10,2) NOT NULL CHECK (price >= 0),
stock_quantity INTEGER NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders(
order_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
customer_id INTEGER NOT NULL,
ordre_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
CONSTRAINT fk_orders_customer 
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id),
CONSTRAINT chk_orders_status CHECK (status IN ('PENDING', 'PAID', 'SHIPPED', 'CANCELLED'))

);
CREATE TABLE order_items(
order_items_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
order_id INTEGER NOT NULL,
product_id INTEGER NOT NULL,
quantity INTEGER NOT NULL CHECK (quantity >= 0),
unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),

CONSTRAINT fk_order_items_order
FOREIGN KEY (order_id)
REFERENCES orders (order_id),

CONSTRAINT fk_items_product
FOREIGN KEY (product_id)
REFERENCES products (product_id),

CONSTRAINT uq_order_product
UNIQUE (order_id, product_id)

);






