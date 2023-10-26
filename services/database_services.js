export default (db) => {
	const s = 'shoe_catalog';
	const t = {
		items: `${s}.cart_items`,
		carts: `${s}.carts`,
		users: `${s}.users`,
		stock: `${s}.stock`,
		shoes: `${s}.shoes`,
		photos: `${s}.photos`
	};

	const getShoes = async (filters) => {
		const valid_filters = ['shoe_id', 'item_id', 'stock_count', 'brand', 'model', 'price', 'color', 'size'];
		const shared_columns = ['shoe_id', 'color', 'size'];

		let query = `
		SELECT st.shoe_id, item_id, price, sold, brand, model, st.color, size, stock_count, photo_url
		FROM ${t.stock} st
		JOIN ${t.shoes} s ON s.shoe_id = st.shoe_id
		JOIN ${t.photos} p ON p.shoe_id = st.shoe_id AND p.color = st.color
		WHERE stock_count > 0
		`;

		for (let type of Object.keys(filters)) {
			if (valid_filters.includes(type) && filters[type]) {
				if (shared_columns.includes(type)) { type = `st.${type}` }

				if (type === "price") {
					query += ` AND ${type} BETWEEN ${filters[type][0]} AND ${filters[type][1]}`;
				} else {
					query += ` AND ${type} = '${filters[type] || filters[type.slice(3)]}'`;
				}
			}
		}

		const shoes = await db.manyOrNone(query)
		return shoes;
	}

	const getItemID = async (shoe_id, color, size) => {
		let query = `
		SELECT item_id FROM ${t.stock} st
		WHERE stock_count > 0
		AND st.shoe_id = ${shoe_id}
		AND color = '${color}'
		AND size = ${size}
		`;

		const item_id = (await db.one(query)).item_id;
		return item_id;
	}

	const sellShoe = async (item_id) => {
		let query = `UPDATE ${t.stock}`;
		query += ` SET stock_count = stock_count - 1`;
		query += ` WHERE item_id = ${item_id}`;
		query += ` AND stock_count > 0`;

		await db.none(query);
	}

	const addShoe = async (shoe) => {
		// const shoe = {
		// 	"brand": "Under Armour",
		// 	"model": "Micro G Valsetz",
		// 	"price": 2899,
		// 	"variants": [
		// 		{ "color": "Black", "size": 9, "stock_count": 2 },
		// 		{ "color": "Black", "size": 10, "stock_count": 2 },
		// 		{ "color": "Black", "size": 11, "stock_count": 1 },
		// 		{ "color": "Gold", "size": 9, "stock_count": 1 },
		// 		{ "color": "Gold", "size": 10, "stock_count": 1 }
		// 	],
		// 	"photos": [
		// 		{ "color": "Black", "photo_url": "https://i.ibb.co/DGNyqNw/ua-mircogvalsetz-black.webp" },
		// 		{ "color": "Gold", "photo_url": "https://i.ibb.co/g4MHQ9x/ua-mircogvalsetz-gold.webp" }
		// 	]
		// }

		// INSERT INTO shoe_catalog.shoes (brand, model, price) VALUES ('Under Armour', 'Micro G Valsetz', 2899);
		// INSERT INTO shoe_catalog.stock (shoe_id, color, size, stock_count) VALUES (1002, 'Gold', 12, 1);
		// INSERT INTO shoe_catalog.photos (shoe_id, color, photo_url) VALUES (1002, 'Gold', 'https://i.ibb.co/g4MHQ9x/ua-mircogvalsetz-gold.webp');

		if (shoe) {
			let query = `
			INSERT INTO ${t.shoes} (brand, model, price)
			VALUES ('${shoe.brand}', '${shoe.model}', ${shoe.price})
			ON CONFLICT ON CONSTRAINT shoe_name DO UPDATE SET price = ${shoe.price}
			RETURNING shoe_id
			`;

			const shoe_id = (await db.one(query)).shoe_id;

			query = `
			INSERT INTO ${t.stock} (shoe_id, color, size, stock_count)
			VALUES
			`;
			for (const variant of shoe.variants) {
				query += ` (${shoe_id}, '${variant.color}', ${variant.size}, ${variant.stock_count}),`;
			}
			query = query.slice(0, -1);
			// TODO: add stock count for variants that already exist
			// query += ` ON CONFLICT ON CONSTRAINT shoe_variant DO UPDATE SET stock_count = stock_count + ${variant.stock_count}`;
			query += ` ON CONFLICT ON CONSTRAINT shoe_variant DO NOTHING`;
			await db.none(query);

			query = `
			INSERT INTO ${t.photos} (shoe_id, color, photo_url)
			VALUES
			`;
			for (const photo of shoe.photos) {
				query += ` (${shoe_id}, '${photo.color}', '${photo.photo_url}'),`;
			}
			query = query.slice(0, -1);
			query += ` ON CONFLICT ON CONSTRAINT shoe_color DO NOTHING`;
			await db.none(query);

			// const shoe_id = 1002;
			// const stock = { "color": "Black", "size": 9, "stock_count": 2 };

			// db.none(`
			// INSERT INTO shoe_catalog.stock (shoe_id, color, size, stock_count)
			// VALUES ($1, $2, $3, $4)
			// ON CONFLICT ON CONSTRAINT shoe_variant DO UPDATE SET stock_count = stock_count + $4
			// `, [shoe_id, stock.color, stock.size, stock.stock_count]);
		}

		// const stock = [
		// 	{ "color": "Black", "size": 9, "stock_count": 2 },
		// 	{ "color": "Black", "size": 10, "stock_count": 2 },
		// 	{ "color": "Black", "size": 11, "stock_count": 1 },
		// 	{ "color": "Gold", "size": 9, "stock_count": 1 },
		// 	{ "color": "Gold", "size": 10, "stock_count": 1 }
		// ];
	}

	const createCart = async (user_id) => {
		let query = `
		INSERT INTO ${t.carts} (user_id)
		VALUES (${user_id})
		`;

		await db.none(query);
	}

	const getCart = async (user_id) => {
		let query = `
		WITH Cart AS (
			SELECT i.item_id, brand, model, color, size, price, item_count, stock_count,
			(price * item_count)::integer AS total
			FROM ${t.items} i
			JOIN ${t.carts} c ON c.cart_id = i.cart_id
			JOIN ${t.users} u ON u.user_id = c.user_id
			JOIN ${t.stock} st ON st.item_id = i.item_id
			JOIN ${t.shoes} s ON s.shoe_id = st.shoe_id
			WHERE u.user_id = ${user_id}
			AND checkout IS NULL )
		SELECT * FROM Cart
		UNION
		SELECT 0, NULL, NULL, NULL, NULL, NULL, (SUM(item_count))::integer, NULL, (SUM(total))::integer
		FROM Cart
		ORDER BY brand, model, color, size
		`;

		return await db.manyOrNone(query);
	}

	const addToCart = async (user_id, item_id, item_count) => {
		let query = `
		INSERT INTO ${t.items} (cart_id, item_id, item_count)
		VALUES (
			( SELECT cart_id FROM ${t.carts} WHERE user_id = ${user_id} AND checkout IS NULL ),
			${item_id},
			${item_count}
		)
		ON CONFLICT (cart_id, item_id) DO UPDATE
		SET item_count = LEAST(
			excluded.item_count,
			(SELECT stock_count FROM shoe_catalog.stock WHERE item_id = ${item_id})
		)
		`;

		await db.none(query);
	}

	const removeFromCart = async (user_id, item_id) => {
		let query = `
		DELETE FROM ${t.items}
		WHERE cart_id IN (SELECT cart_id FROM ${t.carts} WHERE user_id = ${user_id} AND checkout IS NULL)
		AND item_id = ${item_id}
		`;

		await db.none(query);
	}

	const checkoutCart = async (user_id) => {
		let query = `
		UPDATE ${t.carts}
		SET checkout = current_timestamp
		WHERE user_id = ${user_id}
		AND checkout IS NULL
		`;

		await db.none(query);
	}

	const clearCart = async (user_id) => {
		let query = `
		DELETE FROM ${t.items}
		WHERE cart_id IN (SELECT cart_id FROM ${t.carts} WHERE user_id = ${user_id})
		`;

		await db.none(query);
	}

	return {
		getShoes,
		getShoe: getShoes,
		getItemID,
		sellShoe,
		addShoe,
		createCart,
		getCart,
		addToCart,
		removeFromCart,
		checkoutCart,
		clearCart
	}
}