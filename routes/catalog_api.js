import { Router } from "express";
import { services, catalog } from "../index.js";

const shoes_api = Router();
const carts_api = Router();

// ==================== GET SHOES ROUTES ==================== //

// Get shoe catalog data (filtered if queries are provided)
shoes_api.get('/', async (req, res) => {
	try {
		const selected_filters = {};
		if (req.query.shoe_id) { selected_filters.shoe_id = Number(req.query.shoe_id) }
		if (req.query.item_id) { selected_filters.item_id = Number(req.query.item_id) }
		if (req.query.brand) { selected_filters.brand = req.query.brand }
		if (req.query.model) { selected_filters.model = req.query.model }
		if (req.query.price) { selected_filters.price = req.query.price.split('-').map(Number) }
		if (req.query.color) { selected_filters.color = req.query.color }
		if (req.query.size) { selected_filters.size = Number(req.query.size) }

		const shoes = await services.getShoes(selected_filters);
		const filters = catalog.getFilters(shoes);
		const processed_shoes = catalog.formatShoeData(shoes);

		res.json({
			status: "Success",
			filters,
			shoes: processed_shoes
		});

		// if ( errorConditionIsMet ) { throw new Error("Error message, blah blah!") };
	} catch (error) {
		res.json({
			status: "Error",
			error: error.message
		});
	}
});

shoes_api.get('/item_id/:shoe_id/:color/:size', async (req, res) => {
	try {
		const shoe_id = req.params.shoe_id;
		const color = req.params.color;
		const size = req.params.size;

		const item_id = await services.getItemID(shoe_id, color, size);
		res.json({
			status: "Success",
			item_id
		});
	} catch (error) {
		res.json({
			status: "Error",
			error: error.message
		});
	}
});

shoes_api.get('/filters', async (req, res) => {
	try {
		const shoes = await services.getShoes({});
		const filters = catalog.getFilters(shoes);

		res.json({
			status: "Success",
			filters
		});
	} catch (error) {
		res.status(500).json(error);
	}
});

// shoes_api.get('/brand/:brandname', async (req, res) => {
// 	try {
// 		const filters = { brand: req.params.brandname };
// 		const shoes = await services.getShoes(filters);
// 		res.status(200).json(shoes);
// 	} catch (error) {
// 		res.status(500).json(error);
// 	}
// });

// shoes_api.get('/size/:size', async (req, res) => {
// 	try {
// 		const filters = { size: req.params.size };
// 		const shoes = await services.getShoes(filters);
// 		res.status(200).json(shoes);
// 	} catch (error) {
// 		res.status(500).json(error);
// 	}
// });

// shoes_api.get('/brand/:brandname/size/:size', async (req, res) => {
// 	try {
// 		const filters = { brand: req.params.brandname, size: req.params.size };
// 		const shoes = await services.getShoes(filters);
// 		res.status(200).json(shoes);
// 	} catch (error) {
// 		res.status(500).json(error);
// 	}
// });

// ==================== ADD SHOE ROUTES ==================== //

shoes_api.post('/', async (req, res) => {
	try {
		const shoe = req.body;
		await services.addShoe(shoe);
		res.status(200).json("Success");
	} catch (error) {
		res.status(500).json(error);
	}
});

// ==================== SELL SHOE ROUTES ==================== //

shoes_api.post('/sold/:id', async (req, res) => {
	try {
		const item_id = req.params.id;
		await services.sellShoe(item_id)
		res.status(200).json("Success");
	} catch (error) {
		res.status(500).json(error);
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
		res.json({
			status: "Success",
			cart
		});
	} catch (error) {
		res.status(500).json(error);
	}
});

carts_api.post('/:user_id/add/:item_id', async (req, res) => {
	try {
		help
		const user_id = req.params.user_id;
		const item_id = req.params.item_id;
		const item_count = req.query.item_count || 1;
		await services.addToCart(user_id, item_id, item_count);
		res.status(200).json("Success");
	} catch (error) {
		res.status(500).json(error);
	}
});

carts_api.post('/:user_id/remove/:item_id', async (req, res) => {
	try {
		const user_id = req.params.user_id;
		const item_id = req.params.item_id;
		await services.removeFromCart(user_id, item_id);
		res.status(200).json("Success");
	} catch (error) {
		res.status(500).json(error);
	}
});

carts_api.post('/:user_id/checkout', async (req, res) => {
	try {
		const user_id = req.params.user_id;
		await services.checkoutCart(user_id);
		res.status(200).json("Checkout successful");
	} catch (error) {
		res.status(500).json(error);
	}
});

carts_api.post('/:user_id/clear', async (req, res) => {
	try {
		const user_id = req.params.user_id;
		await services.clearCart(user_id);
		res.status(200).json("Cart cleared");
	} catch (error) {
		res.status(500).json(error);
	}
});

export { shoes_api };
export { carts_api };