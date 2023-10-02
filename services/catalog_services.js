export default function (db) {
	async function getShoes() {
		let query = `SELECT * FROM shoe_catalog.shoes`;

		return await db.manyOrNone(query);
	}

	return {
		getShoes
	}
}