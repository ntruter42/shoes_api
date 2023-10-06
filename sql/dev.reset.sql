DROP TABLE IF EXISTS shoe_catalog.cart_items;
DROP TABLE IF EXISTS shoe_catalog.carts;
DROP TABLE IF EXISTS shoe_catalog.users;
DROP TABLE IF EXISTS shoe_catalog.photos;
DROP TABLE IF EXISTS shoe_catalog.stock;
DROP TABLE IF EXISTS shoe_catalog.shoes;

CREATE TABLE shoe_catalog.shoes (
    shoe_id SERIAL PRIMARY KEY,
    brand VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    price INT NOT NULL,
	UNIQUE (brand, name)
);

CREATE TABLE shoe_catalog.stock (
	item_id SERIAL PRIMARY KEY,
    shoe_id INT REFERENCES shoe_catalog.shoes(shoe_id) ON DELETE CASCADE,
	color VARCHAR(255) NOT NULL,
    size INT NOT NULL,
	stock_count INT NOT NULL
);

CREATE TABLE shoe_catalog.photos (
	shoe_id INT REFERENCES shoe_catalog.shoes(shoe_id) ON DELETE CASCADE,
    color VARCHAR(255) NOT NULL,
	photo_url TEXT UNIQUE
);

CREATE TABLE shoe_catalog.users (
	user_id SERIAL PRIMARY KEY,
	username VARCHAR(255) NOT NULL UNIQUE,
	full_name VARCHAR(255) NOT NULL,
	password VARCHAR(60) NOT NULL
);

CREATE TABLE shoe_catalog.carts (
	cart_id SERIAL PRIMARY KEY,
	user_id INT NOT NULL REFERENCES shoe_catalog.users(user_id) ON DELETE CASCADE,
	paid BOOLEAN DEFAULT false
);

CREATE TABLE shoe_catalog.cart_items (
	cart_id INT NOT NULL REFERENCES shoe_catalog.carts(cart_id) ON DELETE CASCADE,
	item_id INT NOT NULL REFERENCES shoe_catalog.stock(item_id) ON DELETE CASCADE,
	item_count INT NOT NULL
);

ALTER SEQUENCE shoe_catalog.shoes_shoe_id_seq RESTART WITH 1000;
ALTER SEQUENCE shoe_catalog.stock_item_id_seq RESTART WITH 1000;
ALTER SEQUENCE shoe_catalog.carts_cart_id_seq RESTART WITH 1000;
ALTER SEQUENCE shoe_catalog.users_user_id_seq RESTART WITH 1000;

-- ADD SHOES
-- Step 1: Add a shoe brand and model name
INSERT INTO shoe_catalog.shoes (brand, name, price) VALUES ('Adidas', 'Breaknet 2.0', 1099); -- returns shoe_id (1000)
-- Step 2: Add color variant
INSERT INTO shoe_catalog.stock (shoe_id, color, size, stock_count) VALUES (1000, 'Black', 6, 11); -- use returned shoe_id (1000), returns item_id (1000)
-- Step 3: Add different size variants for first color variant
INSERT INTO shoe_catalog.stock (shoe_id, color, size, stock_count) VALUES (1000, 'Black', 7, 12);
INSERT INTO shoe_catalog.stock (shoe_id, color, size, stock_count) VALUES (1000, 'Black', 8, 9);
-- Step 4: Add photo url for first color variant
INSERT INTO shoe_catalog.photos (shoe_id, color, photo_url) VALUES (1000, 'Black', 'https://i.ibb.co/3S1WwKj/adidas-breaknet2-blackwhite.webp'); -- use returned item_id (1000)
-- Repeat Steps 2-4 for different color variants
INSERT INTO shoe_catalog.stock (shoe_id, color, size, stock_count) VALUES (1000, 'White', 6, 5);
INSERT INTO shoe_catalog.stock (shoe_id, color, size, stock_count) VALUES (1000, 'White', 7, 11);
INSERT INTO shoe_catalog.stock (shoe_id, color, size, stock_count) VALUES (1000, 'White', 8, 4);
INSERT INTO shoe_catalog.stock (shoe_id, color, size, stock_count) VALUES (1000, 'White', 9, 2);
INSERT INTO shoe_catalog.photos (shoe_id, color, photo_url) VALUES (1000, 'White', 'https://i.ibb.co/JnxgLWL/adidas-breaknet2-whitebluered.webp');

-- Repeat Steps 1-4 for different shoes
INSERT INTO shoe_catalog.shoes (brand, name, price) VALUES ('Nike', 'Air Max 90', 2499);
INSERT INTO shoe_catalog.stock (shoe_id, color, size, stock_count) VALUES (1001, 'Black', 4, 3);
INSERT INTO shoe_catalog.stock (shoe_id, color, size, stock_count) VALUES (1001, 'Black', 5, 5);
INSERT INTO shoe_catalog.stock (shoe_id, color, size, stock_count) VALUES (1001, 'Black', 6, 4);
INSERT INTO shoe_catalog.stock (shoe_id, color, size, stock_count) VALUES (1001, 'Black', 7, 7);
INSERT INTO shoe_catalog.stock (shoe_id, color, size, stock_count) VALUES (1001, 'Black', 8, 5);
INSERT INTO shoe_catalog.stock (shoe_id, color, size, stock_count) VALUES (1001, 'Black', 9, 2);
INSERT INTO shoe_catalog.stock (shoe_id, color, size, stock_count) VALUES (1001, 'Black', 10, 4);
INSERT INTO shoe_catalog.stock (shoe_id, color, size, stock_count) VALUES (1001, 'Black', 11, 2);
INSERT INTO shoe_catalog.photos (shoe_id, color, photo_url) VALUES (1001, 'Black', 'https://i.ibb.co/hBkjfd7/nike-airmax90-black.webp');

INSERT INTO shoe_catalog.shoes (brand, name, price) VALUES ('Under Armour', 'Micro G Valsetz', 2899);
INSERT INTO shoe_catalog.stock (shoe_id, color, size, stock_count) VALUES (1002, 'Gold', 12, 1);
INSERT INTO shoe_catalog.photos (shoe_id, color, photo_url) VALUES (1002, 'Gold', 'https://i.ibb.co/g4MHQ9x/ua-mircogvalsetz-gold.webp');

-- ADD USERS AND CARTS
-- Step 1: Create user account
INSERT INTO shoe_catalog.users (username, full_name, password) VALUES ('ntruter42', 'Nicholas Truter', '$2b$10$cxK.emL.AHc7XzMf5fVaTe5gFjNblOowr71YC.qFN4UJvZ902VKzG'); -- pw = 'codex123123'
-- Step 2: Create cart (after user clicks add to cart, if non-paid cart for user_id doesn't exist)
INSERT INTO shoe_catalog.carts (user_id, paid) VALUES (1000, false);
-- Step 3: Add items to cart
INSERT INTO shoe_catalog.cart_items (cart_id, item_id, item_count) VALUES (1000, 1006, 1); -- use returned cart_id (1000), use inserted item_id (1000)
INSERT INTO shoe_catalog.cart_items (cart_id, item_id, item_count) VALUES (1000, 1012, 1);
-- Step 4: Pay for cart
UPDATE shoe_catalog.carts SET paid = true WHERE user_id = 1000;
-- Repeat Steps 2-4 after user pays for cart
INSERT INTO shoe_catalog.carts (user_id, paid) VALUES (1000, false);

-- Repeat Steps 1-4 for different user
INSERT INTO shoe_catalog.users (username, full_name, password) VALUES ('emusk69', 'Elon Musk', '$2b$10$aTEFSH3iQnefKPT9L3cOFuiEYyzcaKqh9JsiQElcjB2d.Uyrdhu96'); -- pw = 'tesla123'
INSERT INTO shoe_catalog.carts (user_id, paid) VALUES (1001, false);
INSERT INTO shoe_catalog.cart_items (cart_id, item_id, item_count) VALUES (1002, 1015, 1);
