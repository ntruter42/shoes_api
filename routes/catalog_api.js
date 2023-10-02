import { Router } from "express";
import { services } from "../index.js";

const router = Router();

router.get('/shoes', async (req, res) => {
	res.status(200).send(await services.getShoes());
});

export default router;