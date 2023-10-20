-- Select all users
SELECT * FROM shoe_catalog.users;

-- Select all shoes
SELECT * FROM shoe_catalog.shoes;

-- Select all shoe variants
SELECT * FROM shoe_catalog.stock st
JOIN shoe_catalog.shoes s ON s.shoe_id = st.shoe_id;

-- Select all shoes with photos
SELECT * FROM shoe_catalog.shoes s
JOIN shoe_catalog.photos p ON p.shoe_id = s.shoe_id;

-- Select all shoe variants with photos
SELECT * FROM shoe_catalog.stock st
JOIN shoe_catalog.shoes s ON s.shoe_id = st.shoe_id
JOIN shoe_catalog.photos p ON p.shoe_id = st.shoe_id AND p.color = st.color
ORDER BY item_id;

-- Select raw data for shoe catalog display
SELECT st.shoe_id, item_id, price, sold, brand, model, st.color, size, stock_count, photo_url
FROM shoe_catalog.stock st
JOIN shoe_catalog.shoes s ON s.shoe_id = st.shoe_id
JOIN shoe_catalog.photos p ON p.shoe_id = st.shoe_id AND p.color = st.color
WHERE stock_count > 0
AND stock_count >= 2
-- Optional backend filters START here
AND st.shoe_id = 1004
AND item_id = 1030
-- Optional backend filters END here
-- Optional frontend filters START here
AND brand = 'Nike'
AND model = 'Gripknit Phantom GX'
AND price BETWEEN 1000 AND 6000
AND st.color = 'Red'
AND st.size = 8
-- Optional frontend filters END here
ORDER BY brand, model, st.color, st.size;

-- Select colors
SELECT color
FROM shoe_catalog.stock
GROUP BY color;

-- Select sizes
SELECT size
FROM shoe_catalog.stock
GROUP BY size;

-- Decrement stock for a shoe variant
UPDATE shoe_catalog.stock
SET stock_count = stock_count - 1
WHERE item_id = ${item_id}
AND stock_count > 0;

-- Add a shoe model
INSERT INTO shoe_catalog.shoes (brand, model, price)
VALUES ('Adidas', 'Breaknet 2.0', 1099);

-- Add a shoe variant
INSERT INTO shoe_catalog.stock (shoe_id, color, size, stock_count)
VALUES (1000, 'Black', 9, 10);

-- Add a shoe photo
INSERT INTO shoe_catalog.photos (shoe_id, color, photo_url)
VALUES (1000, 'Black', 'https://i.ibb.co/3S1WwKj/adidas-breaknet2-blackwhite.webp');



-- Select cart history for a user
SELECT checkout, i.item_id, brand, model, color, size, price, item_count, stock_count,
(price * item_count)::integer AS total
FROM shoe_catalog.cart_items i
JOIN shoe_catalog.carts c ON c.cart_id = i.cart_id
JOIN shoe_catalog.users u ON u.user_id = c.user_id
JOIN shoe_catalog.stock st ON st.item_id = i.item_id
JOIN shoe_catalog.shoes s ON s.shoe_id = st.shoe_id
WHERE u.user_id = 1000
AND checkout IS NOT NULL
ORDER BY checkout, brand, model, color, size;

-- Select current cart for a user with totals
WITH Cart AS (
	SELECT i.item_id, brand, model, color, size, price, item_count, stock_count,
	(price * item_count)::integer AS total
	FROM shoe_catalog.cart_items i
	JOIN shoe_catalog.carts c ON c.cart_id = i.cart_id
	JOIN shoe_catalog.users u ON u.user_id = c.user_id
	JOIN shoe_catalog.stock st ON st.item_id = i.item_id
	JOIN shoe_catalog.shoes s ON s.shoe_id = st.shoe_id
	WHERE u.user_id = 1000
	AND checkout IS NULL
)
SELECT * FROM Cart
UNION
SELECT 0, NULL, NULL, NULL, NULL, NULL, (SUM(item_count))::integer, NULL, (SUM(total))::integer
FROM Cart
ORDER BY brand, model, color, size;

-- Create new cart
INSERT INTO shoe_catalog.carts (user_id) VALUES (1000)
ON CONFLICT DO NOTHING;

-- Add a shoe variant to cart
INSERT INTO shoe_catalog.cart_items (cart_id, item_id, item_count)
VALUES (
	( SELECT cart_id FROM shoe_catalog.carts WHERE user_id = 1000 AND checkout IS NULL ),
	1027,
	3
)
ON CONFLICT (cart_id, item_id) DO UPDATE
SET item_count = LEAST(
	excluded.item_count,
	(SELECT stock_count FROM shoe_catalog.stock WHERE item_id = 1027)
);

-- Remove a variant from cart
DELETE FROM shoe_catalog.cart_items
WHERE cart_id IN (SELECT cart_id FROM shoe_catalog.carts WHERE user_id = 1000 AND checkout IS NULL)
AND item_id = 1027;

-- Checkout current cart
UPDATE shoe_catalog.carts
SET checkout = current_timestamp
WHERE user_id = 1000
AND checkout IS NULL;

-- TODO: stock_count = stock_count - item_count

-- Clear current cart
DELETE FROM shoe_catalog.cart_items
WHERE cart_id IN (SELECT cart_id FROM shoe_catalog.carts WHERE user_id = 1000);