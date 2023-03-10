DROP TABLE IF EXISTS cart;
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS order_header;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;
-- Create tables and inser values

CREATE TABLE products (
	id bigserial PRIMARY KEY,
	name varchar(50) NOT NULL,
	price money NOT NULL
);

INSERT INTO products (name, price)
VALUES
('coke', 10),
('chips', 5);

CREATE TABLE users (
	id bigserial PRIMARY KEY,
	name varchar(30) NOT NULL
);
INSERT INTO users (name)
VALUES
('Arnold'),
('Sheryl');

CREATE TABLE cart (
	product_id bigint PRIMARY KEY,
	qty bigint
);

CREATE TABLE order_header (
	order_id bigserial PRIMARY KEY,
	user_id bigint REFERENCES users(id) ON DELETE CASCADE,
	order_date timestamp NOT NULL
);

CREATE TABLE order_details (
	order_header bigint REFERENCES order_header(order_id) ON DELETE CASCADE,
	prod_id bigint REFERENCES products(id),
	qty bigint NOT NULL
);

-- Function add to cart
CREATE OR REPLACE FUNCTION addProductToCart(prod_id bigint)
RETURNS void AS $$
BEGIN
	IF EXISTS (SELECT * FROM cart  WHERE product_id = prod_id)
		THEN
			UPDATE cart SET qty = qty + 1  WHERE product_id = prod_id;
		ELSE
			INSERT INTO cart (product_id,qty) VALUES (prod_id,1);
		END IF;
END;
$$ LANGUAGE plpgsql;

-- Call function add to cart
-- Add coke to the cart
SELECT addProductToCart(1);
-- Add coke to the cart
SELECT addProductToCart(1);
-- Add chips to the cart
SELECT addProductToCart(2);
--Results
SELECT * FROM cart;

--Check out
INSERT INTO order_header (user_id, order_date)
VALUES
(2, '2023-04-15 15:30:00');
INSERT INTO order_details (order_header, prod_id, qty)
VALUES
(1, 1, 2),
(1, 2, 1);
SELECT * FROM order_details;
--Adding more produckts to the products table
INSERT INTO products (name, price)
VALUES
('Milk', 29.99),
('Bread', 19.99),
('Shampoo', 40.99),
('Tooth paste', 35.99);

--3
-- Adding products to the cart
SELECT * FROM cart;
SELECT addProductToCart(4);
SELECT * FROM cart;
SELECT addProductToCart(3);
SELECT * FROM cart;
SELECT addProductToCart(5);
SELECT * FROM cart;
SELECT addProductToCart(5);
SELECT * FROM cart;
SELECT addProductToCart(3);
SELECT * FROM cart;
SELECT addProductToCart(5);
SELECT * FROM cart;

-- Deleting products from the cart 

DELETE FROM cart WHERE product_id = 1;

DELETE FROM cart WHERE product_id = 3;

SELECT * FROM cart;
-------------------------- Customer #1 Checkout -------------------------------
INSERT INTO order_header (user_id, order_date)
VALUES
(1, '2023-04-15 19:45:51');
INSERT INTO order_details (order_header, prod_id, qty)
VALUES
(2, 2, 1),
(2, 4, 5),
(2, 4, 3),
(2, 3, 3);

--- Done shoppping, so delete from cart ---
DELETE FROM cart;

------------------------ Customer #2 Add to cart -----------------------------
------------------------ Customer #2 Add to cart & checkout-----------------------
SELECT addProductToCart(1);
SELECT addProductToCart(2);
SELECT addProductToCart(3);
SELECT addProductToCart(5);
INSERT INTO order_header (user_id, order_date)
VALUES
(2, '2023-04-23 09:45:50');
INSERT INTO order_details (order_header, prod_id, qty)
VALUES
(3, 1, 1),
(3, 2, 3),
(3, 3, 2),
(3, 5, 6);
DELETE FROM cart;

SELECT * FROM cart;
----------- Print the orders with select statements with inner joins --------
----------- Print a single order --------------------------------------------
-- Show the user, and their order names, price, sum of all orders
SELECT users.name, oh.order_date, prod.name, prod.price, od.qty
FROM order_header oh
INNER JOIN order_details od
ON oh.order_id = od.order_header
INNER JOIN users
ON users.id = oh.user_id
INNER JOIN products prod
ON prod.id = od.prod_id
WHERE order_id = 3;
-- Printing all orders for a day's shopping
SELECT users.name, oh.order_date, prod.name, prod.price, od.qty
FROM order_header oh
INNER JOIN order_details od
ON oh.order_id = od.order_header
INNER JOIN users
ON users.id = oh.user_id
INNER JOIN products prod
ON prod.id = od.prod_id
WHERE date_part('day', order_date) = '15';


-- Checkout entire cart in a single function 
CREATE OR REPLACE FUNCTION checkoutCart(user_name varchar)
RETURNS void AS $$
BEGIN
	--- If user doesn't exist then add them to the table
	IF NOT EXISTS (SELECT id FROM users WHERE name = user_name)
		THEN
			INSERT INTO users (name) VALUES (user_name);
		END IF;
	--- Insert into order_header
	INSERT INTO order_header (user_id, order_date) 
	VALUES 
		(
			(SELECT id FROM users WHERE name = user_name),
			(SELECT to_timestamp( current_timestamp::varchar, 'YYYY-MM-DD HH24:MI:SS')::timestamp without time zone)
		);
		
	--- Insert into order_details
	INSERT INTO order_details
	(
	 	SELECT 
			(SELECT order_id FROM order_header ORDER BY order_id DESC LIMIT 1),
			product_id,
			qty
	 	FROM cart
	);
	
	-- Clear the cart
	DELETE FROM cart;
END;
$$ LANGUAGE plpgsql;


--checkoutCart() function 
-- Clear the cart before begining --
DELETE FROM cart;

-- Add products to the cart --

SELECT addProductToCartByName('Milk');
SELECT addProductToCartByName('chips');
SELECT addProductToCartByName('Bread');
SELECT addProductToCartByName('coke');

-- Check the cart out
SELECT checkoutCart('Arnold');

--Check out cart 
SELECT users.name, oh.order_date, prod.name, prod.price, od.qty
FROM order_header oh
INNER JOIN order_details od
ON oh.order_id = od.order_header
INNER JOIN users
ON users.id = oh.user_id
INNER JOIN products prod
ON prod.id = od.prod_id
WHERE users.name = 'Arnold';