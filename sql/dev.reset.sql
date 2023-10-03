DROP TABLE IF EXISTS shoe_catalog.shoes;

CREATE TABLE shoe_catalog.shoes (
	shoe_id SERIAL PRIMARY KEY,
	brand VARCHAR(255) NOT NULL,
	name VARCHAR(255) NOT NULL,
	size INT NOT NULL,
	color VARCHAR(255) NOT NULL,
	price FLOAT NOT NULL,
	in_stock INT NOT NULL
);

CREATE TABLE shoe_catalog.users (
	user_id SERIAL PRIMARY KEY,
	username VARCHAR(255) NOT NULL UNIQUE,
	full_name VARCHAR(255) NOT NULL,
	password VARCHAR(60) NOT NULL
);

CREATE TABLE shoe_catalog.carts (
	user_id INT NOT NULL,
	shoe_id INT NOT NULL,
	PRIMARY KEY (user_id, shoe_id),
	FOREIGN KEY (user_id) REFERENCES shoe_catalog.users(user_id) ON DELETE CASCADE,
	FOREIGN KEY (shoe_id) REFERENCES shoe_catalog.shoes(shoe_id) ON DELETE CASCADE
);

ALTER SEQUENCE shoe_catalog.shoes_shoe_id_seq RESTART WITH 100;
ALTER SEQUENCE shoe_catalog.users_user_id_seq RESTART WITH 100;

INSERT INTO shoe_catalog.shoes (brand, name, size, color, price, in_stock) VALUES ('Nike', 'Air Max 90', 9, 'Black', 2499.99, 5);
INSERT INTO shoe_catalog.shoes (brand, name, size, color, price, in_stock) VALUES ('Under Armour', 'Micro G Valsetz', 10, 'Gold', 2899.99, 2);
INSERT INTO shoe_catalog.shoes (brand, name, size, color, price, in_stock) VALUES ('Under Armour', 'Assert 9', 10, 'Black', 999.99, 13);
INSERT INTO shoe_catalog.shoes (brand, name, size, color, price, in_stock) VALUES ('Adidas', 'Breaknet 2.0', 8, 'White', 1099.99, 11);
INSERT INTO shoe_catalog.shoes (brand, name, size, color, price, in_stock) VALUES ('New Balance', '650', 9, 'White', 2899.99, 8);
INSERT INTO shoe_catalog.shoes (brand, name, size, color, price, in_stock) VALUES ('Nike', 'Gripknit Phantom GX', 9, 'Green', 5799.99, 2);

INSERT INTO shoe_catalog.users (username, full_name, password) VALUES ('ntruter42', 'Nicholas Truter', 'codex123');

INSERT INTO shoe_catalog.carts (user_id, shoe_id) VALUES (100, 101);
INSERT INTO shoe_catalog.carts (user_id, shoe_id) VALUES (100, 103);