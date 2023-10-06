-- Select all users
SELECT * FROM shoe_catalog.users

-- Select all shoes
SELECT * FROM shoe_catalog.shoes

-- Select all shoe variants
SELECT * FROM shoe_catalog.shoes
JOIN shoe_catalog.stock
ON shoe_catalog.stock.shoe_id = shoe_catalog.shoes.shoe_id

-- Select colors
SELECT color FROM shoe_catalog.stock
GROUP BY color

-- Select sizes
SELECT color FROM shoe_catalog.stock
GROUP BY color

-- Decrement stock for a shoe variant
UPDATE shoe_catalog.stock
SET stock_count = stock_count - 1
WHERE item_id = ${item_id}
AND stock_count > 0