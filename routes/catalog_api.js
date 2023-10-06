import { Router, response } from "express";
import { services } from "../index.js";

const shoes_api = Router();
const carts_api = Router();

// ==================== GET SHOES ROUTES ==================== //

shoes_api.get('/', async (req, res) => {
	try {
		const filters = {
			brand: req.query.brand,
			size: req.query.size,
			color: req.query.color
		}
		const shoes = await services.getShoes(filters);
		res.status(200).send(shoes);
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
	const cart = await services.getCart(req.params.user_id);
	res.status(200).send(cart);
});

export { shoes_api };
export { carts_api };