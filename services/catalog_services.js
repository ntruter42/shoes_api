export default () => {
	const formatShoeData = (shoes) => {
		const processed_shoes = [];

		shoes.forEach((shoe) => {
			const existing_shoe = processed_shoes.find(p_shoe => p_shoe.shoe_id === shoe.shoe_id);
			const variant = { "item_id": shoe.item_id, "size": shoe.size, "stock_count": shoe.stock_count };

			if (!existing_shoe) {
				const new_shoe = {
					"shoe_id": shoe.shoe_id,
					"brand": shoe.brand,
					"model": shoe.model,
					"price": shoe.price,
					"variants": { [shoe.color]: [variant] },
					"photos": { [shoe.color]: shoe.photo_url }
				}
				processed_shoes.push(new_shoe);
			} else {
				if (!existing_shoe.variants[shoe.color]) {
					existing_shoe.variants[shoe.color] = [variant];
				} else {
					existing_shoe.variants[shoe.color].push(variant);
				}

				if (!existing_shoe.photos[shoe.color]) {
					existing_shoe.photos[shoe.color] = shoe.photo_url;
				}
			}
		});

		return processed_shoes;
	}

	return {
		formatShoeData
	}
}