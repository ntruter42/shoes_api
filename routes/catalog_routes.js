import { Router } from "express";
import { services } from "../index.js";

const router = Router();

router.get('/', async function (req, res) {
	const shoes = await services.getShoes();

	res.render('index', function () {
		shoes
	});
});

export default router;