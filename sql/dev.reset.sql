DROP TABLE IF EXISTS shoe_catalog.shoes;

CREATE TABLE shoe_catalog.shoes (
	id SERIAL PRIMARY KEY,
	color VARCHAR(255) NOT NULL UNIQUE,
	brand VARCHAR(255) NOT NULL,
	price FLOAT NOT NULL,
	size INT NOT NULL,
	in_stock INT NOT NULL
);

ALTER SEQUENCE shoe_catalog.shoes_id_seq RESTART WITH 100;

INSERT INTO shoe_catalog.shoes (color, brand, price, size, in_stock) VALUES ('black', 'Nike', 1999.99, 9, 5);
INSERT INTO shoe_catalog.shoes (color, brand, price, size, in_stock) VALUES ('white', 'Adidas', 2799.99, 8, 6);
INSERT INTO shoe_catalog.shoes (color, brand, price, size, in_stock) VALUES ('red', 'Nike', 3749.99, 10, 3);