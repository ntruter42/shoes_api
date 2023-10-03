import { Router } from "express";
import { services } from "../index.js";

const shoes_api = Router();
const carts_api = Router();

// ========== SHOES API ROUTES ========== //

shoes_api.get('/', async (req, res) => {
	res.status(200).send(await services.getShoes());
});

shoes_api.get('/brand/:brandname', async (req, res) => {
	const filters = { brand: req.params.brandname };
	res.status(200).send(await services.getShoes(filters));
});

shoes_api.get('/size/:size', async (req, res) => {
	const filters = { size: req.params.size };
	res.status(200).send(await services.getShoes(filters));
});

// ========== CARTS API ROUTES ========== //

carts_api.get('/', async (req, res) => {
	const user_id = 100; // get user_id for logged in user ie. req.session.user_id
	res.status(200).send(await services.getCart(user_id));
});

export { shoes_api };
export { carts_api };