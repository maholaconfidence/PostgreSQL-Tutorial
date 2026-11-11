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

INSERT INTO customers (first_name, last_name, email, phone)
VALUES
('Alisha', 'Khumalo', 'aisha@example.com', '0761363519'),
('Daneil', 'Mokoena', 'daneil@example.com', '0739990001');

SELECT * FROM customers;

INSERT INTO products (product_name, description, price, stock_quantity)
VALUES
('Wireless Mouse', 'Wireless computer mouse', 249.99, 30),
('Mechanical Keyboard', 'USB mechanical keyboard', 899.00, 30),
('USB-C Cable', 'One metre USB-C cable', 99.50, 50);
SELECT * FROM products;

SELECT customer_id, first_name, last_name
FROM customers
ORDER BY customer_id;

INSERT INTO orders (customer_id, status)
VALUES 
(1, 'PAID'),
(2,'PENDING');

SELECT order_id, customer_id, status FROM orders;
SELECT product_id, product_name, price FROM products;

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES
(1,1,2,249.99),
(1,3,1,99.50),
(2,2,1,899.00);

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;

SELECT first_name, last_name, email
FROM customers;

SELECT product_name AS product, price AS selling_price
FROM products;

SELECT product_name, price
FROM products
WHERE price > 200;

SELECT product_name, price
FROM products
WHERE price < 300;

SELECT product_name, stock_quantity, price
FROM products
WHERE stock_quantity = 30;

SELECT order_id, status
FROM orders
WHERE status = 'PENDING';


SELECT product_name, price, stock_quantity
FROM products
WHERE price > 100
AND stock_quantity >= 20;

SELECT product_name, price, stock_quantity
FROM products
WHERE price < 150
OR stock_quantity >= 20;

SELECT product_name
FROM products
WHERE product_name LIKE  '%USB%';

SELECT order_id , status
FROM orders
WHERE status IN ('PAID', 'SHIPPED');

SELECT product_name , price
FROM products
WHERE price BETWEEN 100 AND 500;

--Sort results with ORDER BY--

SELECT product_name, price
FROM products
ORDER BY price DESC;

SELECT product_name, price
FROM products
ORDER BY product_name ASC;

--JOIN queries--
--INNER JOIN--

SELECT 
orders.order_id,
customers.first_name,
customers.last_name,
orders.status
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.customer_id; 

--table aliases--
SELECT o.order_id,
c.first_name,
c.last_name,
o.status
FROM orders AS o
INNER JOIN customers AS c
ON o.customer_id = c.customer_id;

--Join three tables--
SELECT
o.order_id,
c.first_name,
p.product_name,
oi.quantity,
oi.unit_price
FROM order AS o
INNER JOIN customers AS c
ON o.customer_id c.customers_id
INNER JOIN order_items AS oi
ON o.order_id = oi.order_id
INNER JOIN products AS p
ON oi.product_id = p.product_id;

--UPDATE, ALTER and DELETE--
-- UPDATE – change existing data--

SELECT product_id , product_name. price
FROM products
WHERE product_name = 'USB-C Cable';

UPDATE product 
SET price = 109.50
WHERE product_name = 'USB-C Cable'



/*Tutorial 1 checkpoint--
 1.A database is an organised place to store and manage this information.A table stores one type of information.
 2.To sore information in tables and let related tables refer to one another. 
 3.In pgAdmin, refresh the Databases list, select brightmart, and open a Query Tool connected to it.

 Tutorail 2 checkpoint
 1. A single shop table might repeat a customer's name and address every time that customer places an order.
 2. An order belongs to a customer. Therefore, the orders table needs a column that identifies the customer who placed it.
 3. Calculations wouldn't be able to occur.
 4. Prevents negative prices.
 5. Because the product's current price may change after an order is placed.

 Tutorail 3 checkpoint
  A primary key uniquely identifies each row in a table.
  For example, two customers may both be named “Alex Smith”. Their names are not reliable unique identifiers. Their customer_id values are.

  A foreign key connects a row in one table to a valid row in another table.
   For example orders.customer_id references customers.customer_id.


 */

 -- LEFT JOIN--
 SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id;
  
--Tutorial 7 – UPDATE, ALTER and DELETE--UPDATE – change existing data--

SELECT product_id, product_name, price
FROM products
WHERE product_name = 'USB-C Cable';
  
 UPDATE products
SET price = 109.50
WHERE product_name = 'USB-C Cable'; 

SELECT product_name, price
FROM products
WHERE product_name = 'USB-C Cable';

UPDATE products
SET price = 109.50;

--Update more than one column--

UPDATE products
SET
    stock_quantity = 45,
    description = 'One metre USB-C charging and data cable'
WHERE product_name = 'USB-C Cable';


--ALTER TABLE – change the table structure

ALTER TABLE customers
ADD COLUMN city VARCHAR(80);









