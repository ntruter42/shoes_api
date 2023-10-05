export default (db) => {
	const getShoes = async (filters) => {
		let query = `SELECT * FROM shoe_catalog.shoes`;
		query += ` WHERE in_stock > 0`;

		if (filters && Object.keys(filters).length > 0) {
			for (const type of Object.keys(filters)) {
				query += ` AND ${type} = '${filters[type]}'`;
			}
		}

		return await db.manyOrNone(query);
	}

	const sellShoe = async (shoe_id) => {
		let query = `UPDATE shoe_catalog.shoes`;
		query += ` SET in_stock = in_stock - 1`;
		query += ` WHERE shoe_id = ${shoe_id}`;
		query += ` AND in_stock > 0`;

		await db.none(query);
	}

	const addShoe = async (shoe) => {
		let query = `INSERT INTO shoe_catalog.shoes`;
		query += ` (brand, name, size, color, price, photo, in_stock)`;
		query += ` VALUES ('${shoe.brand}', '${shoe.name}', ${shoe.size}, '${shoe.color}', ${shoe.price}, '${shoe.photo}', ${shoe.in_stock})`

		await db.none(query);
	}

	const getCart = async (user_id) => {
		let query = `SELECT * FROM shoe_catalog.carts`;
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