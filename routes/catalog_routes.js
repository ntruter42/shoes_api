import { Router } from "express";
import { services } from "../index.js";
import axios from "axios";

const router = Router();

router.get('/', async (req, res) => {
	try {
		const host = `${req.protocol}://${req.get('host')}${req.originalUrl}`;
		const shoes = (await axios.get(`${host}api/shoes`)).data;

		res.render('index', {
			title: "Shoe Catalog",
			shoes
		});
	} catch (error) {
		res.status(500).send('Error');
	}
});

export default router;