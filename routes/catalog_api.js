import { Router, response } from "express";
import { services } from "../index.js";

const shoes_api = Router();
const carts_api = Router();

// ==================== GET SHOES ROUTES ==================== //

// Get shoe catalog data (filtered if queries are provided)
shoes_api.get('/', async (req, res) => {
	try {
		const filters = {};
		if (req.query.shoe_id) { filters.shoe_id = Number(req.query.shoe_id) }
		if (req.query.item_id) { filters.item_id = Number(req.query.item_id) }
		if (req.query.brand) { filters.brand = req.query.brand }
		if (req.query.model) { filters.model = req.query.model }
		if (req.query.price) { filters.price = req.query.price.split('-').map(Number) }
		if (req.query.color) { filters.color = req.query.color }
		if (req.query.size) { filters.size = Number(req.query.size) }

		const shoes = await services.getShoes(filters);
		const processed_shoes = [];
		shoes.forEach((shoe) => {
			const variant = { item_id: shoe.item_id, color: shoe.color, size: shoe.size, stock_count: shoe.stock_count };
			const photo = { color: shoe.color, photo_url: shoe.photo_url };

			if (!processed_shoes.some(p_shoe => p_shoe.shoe_id === shoe.shoe_id)) {
				processed_shoes.push({
					shoe_id: shoe.shoe_id,
					brand: shoe.brand,
					model: shoe.model,
					price: shoe.price,
					variants: [variant],
					photos: [photo]
				});
			} else {
				const update_shoe = processed_shoes.find(p_shoe => p_shoe.shoe_id === shoe.shoe_id);
				update_shoe.variants.push(variant);

				if (!update_shoe.photos.some(photo => photo.color === shoe.color)) {
					update_shoe.photos.push(photo);
				}
			}
		});
		res.status(200).send(processed_shoes);
	} catch (error) {
		res.status(500).send(error);
	}
});

shoes_api.get('/brand/:brandname', async (req, res) => {
	try {
		const filters = { brand: req.params.brandname };
		const shoes = await services.getShoes(filters);
		res.status(200).send(shoes);
	} catch (error) {
		res.status(500).send(error);
	}
});

shoes_api.get('/size/:size', async (req, res) => {
	try {
		const filters = { size: req.params.size };
		const shoes = await services.getShoes(filters);
		res.status(200).send(shoes);
	} catch (error) {
		res.status(500).send(error);
	}
});

shoes_api.get('/brand/:brandname/size/:size', async (req, res) => {
	try {
		const filters = { brand: req.params.brandname, size: req.params.size };
		const shoes = await services.getShoes(filters);
		res.status(200).send(shoes);
	} catch (error) {
		res.status(500).send(error);
	}
});

// ==================== ADD SHOE ROUTES ==================== //

shoes_api.post('/', async (req, res) => {
	try {
		const shoe = req.body;
		await services.addShoe(shoe);
		res.status(200).send("Success");
	} catch (error) {
		res.status(500).send(error);
	}
});

// ==================== SELL SHOE ROUTES ==================== //

shoes_api.post('/sold/:id', async (req, res) => {
	try {
		const item_id = req.params.id;
		await services.sellShoe(item_id)
		res.status(200).send("Success");
	} catch (error) {
		res.status(500).send(error);
	}
});

// ==================== SHOPPING CART ROUTES ==================== //

carts_api.get('/:user_id', async (req, res) => {
	try {
		const user_id = req.params.user_id;
		const cart = await services.getCart(user_id);
		if (cart.length <= 1) {
			throw new Error();
		}
		res.status(200).send(cart);
	} catch (error) {
		res.status(500).send(error);
	}
});

carts_api.post('/:user_id/add/:item_id', async (req, res) => {
	try {
		help
		const user_id = req.params.user_id;
		const item_id = req.params.item_id;
		const item_count = req.query.item_count || 1;
		await services.addToCart(user_id, item_id, item_count);
		res.status(200).send("Success");
	} catch (error) {
		res.status(500).send(error);
	}
});

carts_api.post('/:user_id/remove/:item_id', async (req, res) => {
	try {
		const user_id = req.params.user_id;
		const item_id = req.params.item_id;
		await services.removeFromCart(user_id, item_id);
		res.status(200).send("Success");
	} catch (error) {
		res.status(500).send(error);
	}
});

carts_api.post('/:user_id/checkout', async (req, res) => {
	try {
		const user_id = req.params.user_id;
		await services.checkoutCart(user_id);
		res.status(200).send("Checkout successful");
	} catch (error) {
		res.status(500).send(error);
	}
});

carts_api.post('/:user_id/clear', async (req, res) => {
	try {
		const user_id = req.params.user_id;
		await services.clearCart(user_id);
		res.status(200).send("Cart cleared");
	} catch (error) {
		res.status(500).send(error);
	}
});

export { shoes_api };
export { carts_api };