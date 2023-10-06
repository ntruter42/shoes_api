export default (db) => {
	const t = {
		items: 'shoe_catalog.cart_items',
		carts: 'shoe_catalog.carts',
		users: 'shoe_catalog.users',
		stock: 'shoe_catalog.stock',
		shoes: 'shoe_catalog.shoes',
		photos: 'shoe_catalog.photos'
	};

	const getShoes = async (filters) => {
		let query = `SELECT * FROM ${t.shoes}`;
		query += ` JOIN ${t.stock} ON ${t.stock}.shoe_id = ${t.shoes}.shoe_id`;
		query += ` JOIN ${t.photos} ON ${t.photos}.shoe_id = ${t.shoes}.shoe_id`;
		query += ` AND ${t.photos}.color = ${t.stock}.color`;
		query += ` WHERE stock_count > 0`;

		for (const type of Object.keys(filters || {})) {
			if (filters[type]) {
				if (type === 'color') {
					query += ` AND ${t.stock}.color = '${filters[type]}'`
				} else if (filters[type] != '') {
					query += ` AND ${type} = '${filters[type]}'`;
				}
			}
		}

		return await db.manyOrNone(query);
	}

	const sellShoe = async (item_id) => {
		let query = `UPDATE ${t.stock}`;
		query += ` SET stock_count = stock_count - 1`;
		query += ` WHERE item_id = ${item_id}`;
		query += ` AND stock_count > 0`;

		await db.none(query);
	}

	const addShoe = async (shoe) => {
		// INSERT INTO shoe_catalog.shoes (brand, name, price) VALUES ('Under Armour', 'Micro G Valsetz', 2899);
		// INSERT INTO shoe_catalog.stock(shoe_id, color, size, stock_count) VALUES(1002, 'Gold', 12, 1);
		// INSERT INTO shoe_catalog.photos(shoe_id, color, photo_url) VALUES(1002, 'Gold', 'https://i.ibb.co/g4MHQ9x/ua-mircogvalsetz-gold.webp');

		let query = `INSERT INTO ${t.shoes}`;
		query += ` (brand, name, size, color, price, photo, in_stock)`;
		query += ` VALUES ('${shoe.brand}', '${shoe.name}', ${shoe.size}, '${shoe.color}', ${shoe.price}, '${shoe.photo}', ${shoe.in_stock})`

		await db.none(query);
	}

	const getCart = async (user_id) => {
		let query = `SELECT * FROM ${t.carts}`;
		query += ` WHERE user_id = ${user_id}`;

		return await db.oneOrNone(query);
	}

	return {
		getShoes,
		sellShoe,
		addShoe,
		getCart
	}
}