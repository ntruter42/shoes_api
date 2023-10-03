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

	const getCart = async (user_id) => {
		let query = `SELECT * FROM shoe_catalog.carts`;
		query += ` WHERE user_id = ${user_id}`;

		return await db.oneOrNone(query);
	}

	return {
		getShoes,
		getCart
	}
}