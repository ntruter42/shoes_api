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
		let query = `SELECT * FROM ${t.stock}`;
		query += ` JOIN ${t.shoes} ON ${t.shoes}.shoe_id = ${t.stock}.shoe_id`;
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

	const getShoeCatalog = async () => {
		let query = `SELECT shoe_id, brand, model, price FROM ${t.shoes}`;
		query += ` WHERE shoe_id = ${shoe_id}`;
		query += ` AND stock_count > 0`;
		
		const shoes = await db.manyOrNone(query);
		// Not scalable (slow), process data from getShoes() in API routes instead
		shoes.map(async (shoe) => {
			shoe.variants = await getShoeVariants(shoe.shoe_id);
			shoe.photos = await getShoePhotos(shoe.shoe_id);
		});

		return shoes;
	}

	const getShoeVariants = async (shoe_id) => {
		let query = `SELECT color, size, stock_count FROM ${t.stock}`;
		query += ` WHERE shoe_id = ${shoe_id}`;
		query += ` AND stock_count > 0`;

		return await db.manyOrNone(query);
	}

	const getShoePhotos = async (shoe_id) => {
		let query = `SELECT color, photo_url FROM ${t.photos}`;
		query += ` WHERE shoe_id = ${shoe_id}`;
		query += ` AND stock_count > 0`;

		return await db.manyOrNone(query);
	}

	const getItemID = async (shoe_id, color, size) => {
		let query = `SELECT item_id FROM ${t.stock}`;
		query += ` JOIN ${t.stock} ON ${t.stock}.shoe_id = ${t.shoes}.shoe_id`;
		query += ` WHERE stock_count > 0`;
		query += ` AND ${shoe_id} = ${t.stock}.shoe_id`;
		query += ` AND ${color} = color`;
		query += ` AND ${size} = size`;

		return (await db.one(query)).item_id;
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
			let query = `INSERT INTO ${t.shoes} (brand, model, price)`;
			query += ` VALUES ('${shoe.brand}', '${shoe.model}', ${shoe.price})`;
			query += ` ON CONFLICT ON CONSTRAINT shoe_name DO UPDATE SET price = ${shoe.price}`;
			query += ` RETURNING shoe_id`;

			const shoe_id = (await db.one(query)).shoe_id;

			query = `INSERT INTO ${t.stock} (shoe_id, color, size, stock_count)`;
			query += ` VALUES`;
			for (const variant of shoe.variants) {
				query += ` (${shoe_id}, '${variant.color}', ${variant.size}, ${variant.stock_count}),`;
			}
			query = query.slice(0, -1);
			// TODO: add stock count for variants that already exist
			// query += ` ON CONFLICT ON CONSTRAINT shoe_variant DO UPDATE SET stock_count = stock_count + ${variant.stock_count}`;
			await db.none(query);

			query = `INSERT INTO ${t.photos} (shoe_id, color, photo_url)`;
			query += ` VALUES`;
			for (const photo of shoe.photos) {
				query += ` (${shoe_id}, '${photo.color}', '${photo.photo_url}'),`;
			}
			query = query.slice(0, -1);
			await db.none(query);
		}
	}

	const getCart = async (user_id) => {
		let query = `SELECT * FROM ${t.carts}`;
		query += ` WHERE user_id = ${user_id}`;
		query += ` AND paid = false`;

		return await db.one(query);
	}

	return {
		getShoes,
		getShoeCatalog,
		getItemID,
		sellShoe,
		addShoe,
		getCart
	}
}