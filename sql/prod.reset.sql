DROP TABLE IF EXISTS shoe_catalog.cart_items;
DROP TABLE IF EXISTS shoe_catalog.carts;
DROP TABLE IF EXISTS shoe_catalog.users;
DROP TABLE IF EXISTS shoe_catalog.photos;
DROP TABLE IF EXISTS shoe_catalog.stock;
DROP TABLE IF EXISTS shoe_catalog.shoes;

CREATE TABLE shoe_catalog.shoes (
    shoe_id SERIAL PRIMARY KEY,
    brand VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
	type VARCHAR(255) NOT NULL,
	-- gender VARCHAR(6) NOT NULL,
    price INT NOT NULL,
	sold INT DEFAULT 0,
	liked BOOLEAN DEFAULT false,
	CONSTRAINT shoe_name UNIQUE (brand, model)
);

CREATE TABLE shoe_catalog.stock (
	item_id SERIAL PRIMARY KEY,
	shoe_id INT REFERENCES shoe_catalog.shoes(shoe_id) ON DELETE CASCADE,
	color VARCHAR(255) NOT NULL,
	size INT NOT NULL,
	stock_count INT NOT NULL,
	CONSTRAINT shoe_variant UNIQUE (shoe_id, color, size)
);

CREATE TABLE shoe_catalog.photos (
	shoe_id INT REFERENCES shoe_catalog.shoes(shoe_id) ON DELETE CASCADE,
    color VARCHAR(255) NOT NULL,
	photo_url TEXT UNIQUE NOT NULL,
	CONSTRAINT shoe_color UNIQUE (shoe_id, color)
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
	checkout TIMESTAMP DEFAULT NULL,
	CONSTRAINT current_cart UNIQUE (user_id, checkout)
);

CREATE TABLE shoe_catalog.cart_items (
	cart_id INT NOT NULL REFERENCES shoe_catalog.carts(cart_id) ON DELETE CASCADE,
	item_id INT NOT NULL REFERENCES shoe_catalog.stock(item_id) ON DELETE CASCADE,
	PRIMARY KEY (cart_id, item_id),
	item_count INT NOT NULL DEFAULT 1
);

ALTER SEQUENCE shoe_catalog.shoes_shoe_id_seq RESTART WITH 1000;
ALTER SEQUENCE shoe_catalog.stock_item_id_seq RESTART WITH 1000;
ALTER SEQUENCE shoe_catalog.carts_cart_id_seq RESTART WITH 1000;
ALTER SEQUENCE shoe_catalog.users_user_id_seq RESTART WITH 1000;

INSERT INTO shoe_catalog.shoes (brand, model, type, price)
VALUES
	('Under Armour', 'Project Rock 3', 'Slides', 1399),
	('Under Armour', 'Surge 3', 'Running Shoes', 1299),
	('Under Armour', 'Micro G Valsetz Mid', 'Utility Boots', 2999),
	('Under Armour', 'Micro G Valsetz', 'Utility Boots', 3499),
	('Nike', 'Air Force 1 ''07', 'Sneakers', 2199),
	('Nike', 'Gripknit Phantom GX Elite', 'Soccer Boots', 5799),
	('Nike', 'Air Jordan 1 Retro High OG', 'Sneakers', 3499),
	('Nike', 'Air Jordan 1 Hi FlyEase', 'Sneakers', 3399),
	('Adidas', 'Originals x Moncler NMD Mid', 'Designer Boots', 13999),
	('Adidas', 'Breaknet 2.0', 'Sneakers', 1199),
	('New Balance', 'FuelCell Summit Unknown v4', 'Running Shoes', 2599),
	('New Balance', '650', 'Sneakers', 2799),
;

INSERT INTO shoe_catalog.stock (shoe_id, color, size, stock_count)
VALUES
	-- Under Armour Project Rock 3 Slides
	(1000, 'Black', 7, 10),
	(1000, 'Black', 8, 10),
	(1000, 'Black', 9, 10),
	(1000, 'Black', 10, 10),
	(1000, 'Black', 11, 10),

	(1000, 'White', 6, 10),
	(1000, 'White', 7, 10),
	(1000, 'White', 8, 10),
	(1000, 'White', 9, 10),
	(1000, 'White', 10, 10),
	(1000, 'White', 11, 10),
	(1000, 'White', 12, 10),

	-- Under Armour Surge 3 Running Shoes
	(1001, 'White', 6, 10),
	(1001, 'White', 7, 10),
	(1001, 'White', 8, 10),
	(1001, 'White', 9, 10),

	(1001, 'Grey+White', 6, 10),
	(1001, 'Grey+White', 7, 10),
	(1001, 'Grey+White', 8, 10),
	(1001, 'Grey+White', 9, 10),
	(1001, 'Grey+White', 10, 10),

	(1001, 'Blue+White', 8, 10),
	(1001, 'Blue+White', 9, 10),
	(1001, 'Blue+White', 10, 10),
	(1001, 'Blue+White', 11, 10),
	(1001, 'Blue+White', 12, 10),

	(1001, 'Grey+Lime+Slate', 7, 10),
	(1001, 'Grey+Lime+Slate', 8, 10),
	(1001, 'Grey+Lime+Slate', 9, 10),
	(1001, 'Grey+Lime+Slate', 10, 10),
	
	-- Under Armour Micro G Valsetz Mid Utility Boots
	(1002, 'Black', 8, 10),
	(1002, 'Black', 9, 10),
	(1002, 'Black', 10, 10),
	(1002, 'Black', 11, 10),
	(1002, 'Black', 12, 10),

	(1002, 'Gold', 9, 10),
	(1002, 'Gold', 10, 10),
	(1002, 'Gold', 11, 10),

	-- Under Armour Micro G Valsetz Utility Boots
	(1003, 'Black', 8, 10),
	(1003, 'Black', 9, 10),
	(1003, 'Black', 10, 10),
	(1003, 'Black', 11, 10),
	(1003, 'Black', 12, 10),

	-- Nike Air Force 1 '07 Sneakers
	(1004, 'Black', 6, 10),
	(1004, 'Black', 7, 10),
	(1004, 'Black', 8, 10),
	(1004, 'Black', 9, 10),
	(1004, 'Black', 10, 10),

	(1004, 'White', 6, 10),
	(1004, 'White', 7, 10),
	(1004, 'White', 8, 10),
	(1004, 'White', 9, 10),
	(1004, 'White', 10, 10),

	-- Nike Gripknit Phantom GX Elite Soccer Boots
	(1005, 'Black+White+Grey', 7, 10),
	(1005, 'Black+White+Grey', 8, 10),
	(1005, 'Black+White+Grey', 9, 10),
	(1005, 'Black+White+Grey', 11, 10),

	(1005, 'Black+Red+Grey', 5, 10),
	(1005, 'Black+Red+Grey', 6, 10),
	(1005, 'Black+Red+Grey', 7, 10),
	(1005, 'Black+Red+Grey', 8, 10),
	(1005, 'Black+Red+Grey', 9, 10),
	(1005, 'Black+Red+Grey', 10, 10),
	(1005, 'Black+Red+Grey', 11, 10),
	(1005, 'Black+Red+Grey', 12, 10),

	(1005, 'Green+Orange+Lime', 6, 10),
	(1005, 'Green+Orange+Lime', 7, 10),
	(1005, 'Green+Orange+Lime', 8, 10),
	(1005, 'Green+Orange+Lime', 9, 10),
	(1005, 'Green+Orange+Lime', 10, 10),
	(1005, 'Green+Orange+Lime', 11, 10),

	-- Nike Air Jordan 1 Retro High OG Sneakers
	(1006, 'Black+Brown', 6, 10),
	(1006, 'Black+Brown', 7, 10),
	(1006, 'Black+Brown', 8, 10),

	(1006, 'Grey+White', 6, 10),
	(1006, 'Grey+White', 7, 10),
	(1006, 'Grey+White', 8, 10),
	(1006, 'Grey+White', 9, 10),

	(1006, 'Grey+White+Black', 6, 10),
	(1006, 'Grey+White+Black', 7, 10),
	(1006, 'Grey+White+Black', 8, 10),
	(1006, 'Grey+White+Black', 9, 10),
	(1006, 'Grey+White+Black', 11, 10),

	(1006, 'Brown+White', 7, 10),
	(1006, 'Brown+White', 8, 10),
	(1006, 'Brown+White', 9, 10),
	(1006, 'Brown+White', 10, 10),

	-- Nike Air Jordan 1 Hi FlyEase Sneakers
	(1007, 'Black+Purple+White', 6, 10),
	(1007, 'Black+Purple+White', 7, 10),
	(1007, 'Black+Purple+White', 8, 10),
	(1007, 'Black+Purple+White', 9, 10),
	(1007, 'Black+Purple+White', 10, 10),

	-- Adidas Originals x Moncler NMD Mid Designer Shoes
	(1008, 'Black', 8, 10),
	(1008, 'Black', 10, 10),

	(1008, 'White', 7, 10),
	(1008, 'White', 8, 10),
	(1008, 'White', 9, 10),
	(1008, 'White', 10, 10),

	(1008, 'Blue+White', 7, 10),
	(1008, 'Blue+White', 8, 10),
	(1008, 'Blue+White', 9, 10),
	(1008, 'Blue+White', 10, 10),

	-- Adidas Breaknet 2.0 Sneakers
	(1009, 'Black+White', 6, 10),
	(1009, 'Black+White', 7, 10),
	(1009, 'Black+White', 8, 10),
	(1009, 'Black+White', 9, 10),
	(1009, 'Black+White', 10, 10),
	(1009, 'Black+White', 11, 10),
	(1009, 'Black+White', 12, 10),

	(1009, 'White+Black', 6, 10),
	(1009, 'White+Black', 8, 10),

	(1009, 'White+Blue+Red', 6, 10),
	(1009, 'White+Blue+Red', 7, 10),
	(1009, 'White+Blue+Red', 9, 10),
	(1009, 'White+Blue+Red', 10, 10),
	
	-- New Balance FuelCell Summit Unknown v4 Running Shoes
	(1010, 'Yellow+Violet', 8, 10),
	(1010, 'Yellow+Violet', 9, 10),
	(1010, 'Yellow+Violet', 10, 10),
	(1010, 'Yellow+Violet', 11, 10),
	(1010, 'Yellow+Violet', 12, 10),

	(1010, 'Blue', 6, 10),
	(1010, 'Blue', 7, 10),
	(1010, 'Blue', 8, 10),
	(1010, 'Blue', 9, 10),
	(1010, 'Blue', 10, 10),
	(1010, 'Blue', 11, 10),
	(1010, 'Blue', 12, 10),

	-- New Balance 650 Sneakers
	(1011, 'White+Black', 6, 10),
	(1011, 'White+Black', 7, 10),
	(1011, 'White+Black', 8, 10),
	(1011, 'White+Black', 9, 10),
	(1011, 'White+Black', 10, 10),
	(1011, 'White+Black', 11, 10),

	(1011, 'White', 7, 10),
	(1011, 'White', 8, 10),
	(1011, 'White', 9, 10),

	(1011, 'White+Blue', 6, 10),
	(1011, 'White+Blue', 7, 10),
	(1011, 'White+Blue', 8, 10),
	(1011, 'White+Blue', 9, 10),
	(1011, 'White+Blue', 10, 10),

	(1011, 'White+Green', 9, 10),
	(1011, 'White+Green', 11, 10),
	(1011, 'White+Green', 12, 10),

	(1011, 'White+Purple', 6, 10),
	(1011, 'White+Purple', 7, 10),
	(1011, 'White+Purple', 9, 10),
	(1011, 'White+Purple', 10, 10),

	(1011, 'White+Red', 6, 10),
	(1011, 'White+Red', 7, 10),
	(1011, 'White+Red', 8, 10),
	(1011, 'White+Red', 9, 10),
	(1011, 'White+Red', 10, 10),
	(1011, 'White+Red', 11, 10),

	(1011, 'White+Yellow', 7, 10),
	(1011, 'White+Yellow', 9, 10),

	(1011, 'Black+Red', 6, 10),
	(1011, 'Black+Red', 7, 10),
	(1011, 'Black+Red', 8, 10),
	(1011, 'Black+Red', 9, 10),
	(1011, 'Black+Red', 10, 10),
	(1011, 'Black+Red', 11, 10),
;

INSERT INTO shoe_catalog.photos (shoe_id, color, photo_url)
VALUES
	(1000, 'Black', '/assets/images/shoes/under+armour-project+rock+3-black.png'),
	(1000, 'White', '/assets/images/shoes/under+armour-project+rock+3-white.png'),

	(1001, 'White', '/assets/images/shoes/under+armour-surge+3-white.png'),
	(1001, 'Grey+White', '/assets/images/shoes/under+armour-surge+3-grey+white.png'),
	(1001, 'Blue+White', '/assets/images/shoes/under+armour-surge+3-blue+white.png'),
	(1001, 'Grey+Lime+Slate', '/assets/images/shoes/under+armour-surge+3-grey+lime+slate.png'),

	(1002, 'Black', '/assets/images/shoes/under+armour-micro+g+valsetz+mid-black.png'),
	(1002, 'Gold', '/assets/images/shoes/under+armour-micro+g+valsetz+mid-gold.png'),

	(1003, 'Black', '/assets/images/shoes/under+armour-micro+g+valsetz-black.png'),

	(1004, 'Black', '/assets/images/shoes/nike-air+force+1+''07-black.png'),
	(1004, 'White', '/assets/images/shoes/nike-air+force+1+''07-white.png'),

	(1005, 'Black+White+Grey', '/assets/images/shoes/nike-gripknit+phantom+gx+elite-black+white+grey.png'),
	(1005, 'Black+Red+Grey', '/assets/images/shoes/nike-gripknit+phantom+gx+elite-black+red+grey.png'),
	(1005, 'Green+Orange+Lime', '/assets/images/shoes/nike-gripknit+phantom+gx+elite-green+orange+lime.png'),

	(1006, 'Black+Brown', '/assets/images/shoes/nike-air+jordan+1+retro+high+og-black+brown.png'),
	(1006, 'Grey+white', '/assets/images/nike-air+jordan+1+retro+high+og-grey+white.png'),
	(1006, 'Grey+White+Black', '/assets/images/nike-air+jordan+1+retro+high+og-grey+white+black.png'),
	(1006, 'Brown+White', '/assets/images/nike-air+jordan+1+retro+high+og-brown+white.png'),

	(1007, 'Black+Purple+White', '/assets/images/shoes/nike-air+jordan+1+hi+flyease-black+purple+white.png'),

	(1008, 'Black', '/assets/images/shoes/adidas-originals+x+moncler+nmd+mid-black.png'),
	(1008, 'White', '/assets/images/shoes/adidas-originals+x+moncler+nmd+mid-white.png'),
	(1008, 'Blue+white', '/assets/images/shoes/adidas-originals+x+moncler+nmd+mid-blue+white.png'),

	(1009, 'Black+White', '/assets/images/shoes/adidas-breaknet+2.0-black+white.png'),
	(1009, 'White+Black', '/assets/images/shoes/adidas-breaknet+2.0-white+black.png'),
	(1009, 'White+Blue+Red', '/assets/images/shoes/adidas-breaknet+2.0-white+blue+red.png'),

	(1010, 'Yellow+Violet', '/assets/images/shoes/new+balance-fuelcell+summit+unknown+v4-yellow+violet.png'),
	(1010, 'Blue', '/assets/images/shoes/new+balance-fuelcell+summit+unknown+v4-blue.png'),

	(1011, 'White', '/assets/images/shoes/new+balance-650-white.png'),
	(1011, 'White+Black', '/assets/images/shoes/new+balance-650-white+black.png'),
	(1011, 'White+Blue', '/assets/images/shoes/new+balance-650-white+blue.png'),
	(1011, 'White+Green', '/assets/images/shoes/new+balance-650-white+green.png'),
	(1011, 'White+Purple', '/assets/images/shoes/new+balance-650-white+purple.png'),
	(1011, 'White+Red', '/assets/images/shoes/new+balance-650-white+red.png'),
	(1011, 'White+Yellow', '/assets/images/shoes/new+balance-650-white+yellow.png'),
	(1011, 'Black+Red', '/assets/images/shoes/new+balance-650-black+red.png'),
;

INSERT INTO shoe_catalog.users (username, full_name, password) VALUES ('ntruter42', 'Nicholas Truter', '$2b$10$cxK.emL.AHc7XzMf5fVaTe5gFjNblOowr71YC.qFN4UJvZ902VKzG');
INSERT INTO shoe_catalog.carts (user_id) VALUES (1000)
;

INSERT INTO shoe_catalog.users (username, full_name, password) VALUES ('emusk69', 'Elon Musk', '$2b$10$aTEFSH3iQnefKPT9L3cOFuiEYyzcaKqh9JsiQElcjB2d.Uyrdhu96');
INSERT INTO shoe_catalog.carts (user_id) VALUES (1001)
;

INSERT INTO shoe_catalog.cart_items (cart_id, item_id, item_count)
VALUES
	(1000, 1000, 1)
;

UPDATE shoe_catalog.carts SET checkout = current_timestamp WHERE user_id = 1000 AND checkout IS NULL;
INSERT INTO shoe_catalog.carts (user_id) VALUES (1000);