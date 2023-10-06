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