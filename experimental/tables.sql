-- CREATE TABLE shoe_catalog.shoes (
--     shoe_id SERIAL PRIMARY KEY,
--     brand VARCHAR(255) NOT NULL,
--     name VARCHAR(255) NOT NULL,
--     variants JSONB NOT NULL,
--     price FLOAT NOT NULL,
--     stock INT NOT NULL,
-- 	UNIQUE (brand, name)
-- );

-- INSERT INTO shoe_catalog.shoes
-- 	(brand, name, attributes, price, photo, in_stock)
-- VALUES (
--     'Nike',
--     'Air Jordan 1',
--     [{"size": 11, "color": "Black", "photo": "http://www.shoe-images.com/Nike/AirJordan1/Black"}],
--     2499.95,
--     10
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

CREATE TABLE shoe_catalog.sizes (
    size INT NOT NULL PRIMARY KEY
);

CREATE TABLE shoe_catalog.colors (
    color VARCHAR(255) NOT NULL PRIMARY KEY
);

CREATE TABLE shoe_catalog.photos (
    shoe_id INT REFERENCES shoe_catalog.shoes(shoe_id) ON DELETE CASCADE,
	color_id INT REFERENCES shoe_catalog.colors(color_id) ON DELETE CASCADE,
	photo_url TEXT
);

CREATE TABLE shoe_catalog.stock (
    shoe_id INT REFERENCES shoe_catalog.shoes(shoe_id) ON DELETE CASCADE,
	color_id INT REFERENCES shoe_catalog.colors(color_id) ON DELETE CASCADE,
    size_id INT REFERENCES shoe_catalog.sizes(size_id) ON DELETE CASCADE,
	count INT NOT NULL
);

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

-- INDEXING FOR FASTER LOOKUPS
CREATE INDEX idx_brand_name ON shoe_catalog.shoes (brand, name);

-- CART DISPLAY
SELECT full_name, brand, name, size, color, item_count, price FROM shoe_catalog.cart_items
JOIN shoe_catalog.users ON shoe_catalog.users.user_id = shoe_catalog.carts.user_id;
JOIN shoe_catalog.stock ON shoe_catalog.stock.item_id = shoe_catalog.cart_items.item_id
JOIN shoe_catalog.shoes ON shoe_catalog.shoes.shoe_id = shoe_catalog.stock.shoe_id
JOIN shoe_catalog.carts ON shoe_catalog.carts.cart_id = shoe_catalog.cart_items.cart_id