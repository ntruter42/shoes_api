router.post('/api/shoes/add', async (req, res) => {
	try {
		const shoe_data = req.body;
		const response = await axios.post('http://localhost:3000/api/shoes/add', shoe_data);

		if (response.status === 200) {
			res.status(200).send('Shoe added successfully');
		} else {
			res.status(500).send('Failed to add shoe');
		}
	} catch (error) {
		console.log(error);
		res.status(500).send('An error occurred');
	}
});