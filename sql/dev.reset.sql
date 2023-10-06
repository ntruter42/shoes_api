DROP TABLE IF EXISTS shoe_catalog.users;
DROP TABLE IF EXISTS shoe_catalog.shoes;
DROP TABLE IF EXISTS shoe_catalog.sizes;
DROP TABLE IF EXISTS shoe_catalog.colors;
DROP TABLE IF EXISTS shoe_catalog.photos;
DROP TABLE IF EXISTS shoe_catalog.stock;
DROP TABLE IF EXISTS shoe_catalog.carts;
DROP TABLE IF EXISTS shoe_catalog.cart_items;

-- CREATE TABLE shoe_catalog.shoes (
-- 	shoe_id SERIAL PRIMARY KEY,
-- 	brand VARCHAR(255) NOT NULL,
-- 	name VARCHAR(255) NOT NULL,
-- 	size INT NOT NULL,
-- 	color VARCHAR(255) NOT NULL,
-- 	photo VARCHAR(255) NOT NULL,
-- 	price FLOAT NOT NULL,
-- 	in_stock INT NOT NULL
-- );

CREATE TABLE shoe_catalog.users (
	user_id SERIAL PRIMARY KEY,
	username VARCHAR(255) NOT NULL UNIQUE,
	full_name VARCHAR(255) NOT NULL,
	password VARCHAR(60) NOT NULL
);

CREATE TABLE shoe_catalog.shoes (
    shoe_id SERIAL PRIMARY KEY,
    brand VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    price DECIMAL NOT NULL,
	UNIQUE (brand, name)
);

CREATE TABLE shoe_catalog.stock (
    shoe_id INT REFERENCES shoe_catalog.shoes(shoe_id) ON DELETE CASCADE,
	color VARCHAR(255) NOT NULL,
    size INT NOT NULL,
	count INT NOT NULL,
	UNIQUE (color, size)
);

CREATE TABLE shoe_catalog.photos (
    shoe_id INT REFERENCES shoe_catalog.shoes(shoe_id) ON DELETE CASCADE,
	color VARCHAR(255) REFERENCES shoe_catalog.stock(color) ON DELETE CASCADE,
	photo_url TEXT
);

CREATE TABLE shoe_catalog.carts (
	cart_id SERIAL PRIMARY KEY,
	user_id INT NOT NULL REFERENCES shoe_catalog.users(user_id) ON DELETE CASCADE,
	paid BOOLEAN DEFAULT false
);

CREATE TABLE shoe_catalog.cart_items (
	cart_id INT NOT NULL REFERENCES shoe_catalog.carts(cart_id) ON DELETE CASCADE
	shoe_id INT NOT NULL REFERENCES shoe_catalog.shoes(shoe_id) ON DELETE CASCADE
);

ALTER SEQUENCE shoe_catalog.users_user_id_seq RESTART WITH 1000;
ALTER SEQUENCE shoe_catalog.shoes_shoe_id_seq RESTART WITH 1000;

INSERT INTO shoe_catalog.shoes (brand, name, size, color, price, photo, in_stock) VALUES ('Nike', 'Air Max 90', 10, 'Black', 2499.99, 'https://i.ibb.co/hBkjfd7/nike-airmax90-black.webp', 5);
INSERT INTO shoe_catalog.shoes (brand, name, size, color, price, photo, in_stock) VALUES ('Under Armour', 'Micro G Valsetz', 10, 'Gold', 2899.99, 'https://i.ibb.co/g4MHQ9x/ua-mircogvalsetz-gold.webp', 2);
INSERT INTO shoe_catalog.shoes (brand, name, size, color, price, photo, in_stock) VALUES ('Under Armour', 'Assert 9', 9, 'Black', 999.99, 'https://i.ibb.co/JKLCrCb/ua-assert9-blackwhite.webp', 13);
INSERT INTO shoe_catalog.shoes (brand, name, size, color, price, photo, in_stock) VALUES ('Adidas', 'Breaknet 2.0', 8, 'White', 1099.99, 'https://i.ibb.co/JnxgLWL/adidas-breaknet2-whitebluered.webp', 11);
INSERT INTO shoe_catalog.shoes (brand, name, size, color, price, photo, in_stock) VALUES ('New Balance', '650', 9, 'White', 2899.99, 'https://i.ibb.co/D7J9f9X/nb-650-whiteblack.webp', 8);
INSERT INTO shoe_catalog.shoes (brand, name, size, color, price, photo, in_stock) VALUES ('Nike', 'Gripknit Phantom GX', 9, 'Green', 5799.99, 'https://i.ibb.co/ySXrhWL/nike-gripknit-phantom-gx-greenorange.webp', 2);

INSERT INTO shoe_catalog.users (username, full_name, password) VALUES ('ntruter42', 'Nicholas Truter', 'codex123');

INSERT INTO shoe_catalog.carts (user_id, shoe_id) VALUES (100, 101);
INSERT INTO shoe_catalog.carts (user_id, shoe_id) VALUES (100, 103);

-- https://ibb.co/WBnFQCM - https://i.ibb.co/3S1WwKj/adidas-breaknet2-blackwhite.webp
-- https://ibb.co/rkbNPKP - https://i.ibb.co/JnxgLWL/adidas-breaknet2-whitebluered.webp
-- https://ibb.co/LZy8m42 - https://i.ibb.co/jrYTm71/nb-650v2-blackred.webp
-- https://ibb.co/Vjzn98n - https://i.ibb.co/4mXvtxv/nb-650v2-whiteblack.webp
-- https://ibb.co/mcyXqVq - https://i.ibb.co/yQkYycy/nb-650v2-whiteblue.webp
-- https://ibb.co/ZVxbsMd - https://i.ibb.co/W6fR92n/nb-650v2-whiteyellow.webp
-- https://ibb.co/y896F6T - https://i.ibb.co/D7J9f9X/nb-650-whiteblack.webp
-- https://ibb.co/CJgcpMX - https://i.ibb.co/Gsy6ft1/nb-650-whiteblue.webp
-- https://ibb.co/X7Vctyy - https://i.ibb.co/QPXyM88/nb-650-whitered.webp
-- https://ibb.co/Mcb4612 - https://i.ibb.co/hBkjfd7/nike-airmax90-black.webp
-- https://ibb.co/88cDVCz - https://i.ibb.co/SvrXpjQ/nike-gripknit-phantom-gx-blackred.webp
-- https://ibb.co/Bfj5SLC - https://i.ibb.co/2FP1fqk/nike-gripknit-phantom-gx-blackwhite.webp
-- https://ibb.co/wsRfJMD - https://i.ibb.co/ySXrhWL/nike-gripknit-phantom-gx-greenorange.webp
-- https://ibb.co/yXTVgVM - https://i.ibb.co/JKLCrCb/ua-assert9-blackwhite.webp
-- https://ibb.co/8zJphJP - https://i.ibb.co/DGNyqNw/ua-mircogvalsetz-black.webp
-- https://ibb.co/BnVdv39 - https://i.ibb.co/g4MHQ9x/ua-mircogvalsetz-gold.webp