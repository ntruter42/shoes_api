import { Router } from "express";
import { services } from "../index.js";
import axios from "axios";

const router = Router();

router.get('/', async (req, res) => {
	const shoes = await services.getShoes();

	res.render('index', {
		shoes
	});
});

export default router;