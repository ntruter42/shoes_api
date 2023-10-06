// TODO:
// Process shoe data from form into frontend object model to add shoe
// May have to use multiple forms, one form per variant and per photo

// ==================== SINGLE SHOE / VARIANT ==================== //

const frontend_shoe = {
	"brand": "Under Armour",
	"model": "Micro G Valsetz",
	"price": 2899,
	"variants": [
		{ "color": "Gold", "size": 12, "stock_count": 1 }
	],
	"photos": [
		{ "color": "Gold", "photo_url": "https://i.ibb.co/g4MHQ9x/ua-mircogvalsetz-gold.webp" }
	]
};

const backend_shoe = {
	"shoe_id": 1002,
	"brand": "Under Armour",
	"model": "Micro G Valsetz",
	"price": 2899,
	"item_id": 1005,
	"color": "Gold",
	"size": 12,
	"stock_count": 1,
	"photo_url": "https://i.ibb.co/g4MHQ9x/ua-mircogvalsetz-gold.webp"
};

// ==================== ENTIRE SHOE CATALOG ==================== //

const frontend_shoe_catalog = [
	{
		"shoe_id": 1000,
		"brand": "Adidas",
		"model": "Breaknet 2.0",
		"price": 1099,
		"variants": [
			{ "item_id": 1000, "color": "Black", "size": 6, "stock_count": 11 },
			{ "item_id": 1001, "color": "Black", "size": 7, "stock_count": 12 },
			{ "item_id": 1002, "color": "White", "size": 6, "stock_count": 5 }
		],
		"photos": [
			{ "color": "Black", "photo_url": "https://i.ibb.co/3S1WwKj/adidas-breaknet2-blackwhite.webp" },
			{ "color": "White", "photo_url": "https://i.ibb.co/JnxgLWL/adidas-breaknet2-whitebluered.webp" }
		]
	}, {
		"shoe_id": 1001,
		"brand": "Nike",
		"model": "Air Max 90",
		"price": 2499,
		"variants": [
			{ "item_id": 1003, "color": "Black", "size": 4, "stock_count": 3 },
			{ "item_id": 1004, "color": "Black", "size": 5, "stock_count": 5 }
		],
		"photos": [
			{ "color": "Black", "photo_url": "https://i.ibb.co/hBkjfd7/nike-airmax90-black.webp" }
		]
	}, {
		"shoe_id": 1002,
		"brand": "Under Armour",
		"model": "Micro G Valsetz",
		"price": 2899,
		"variants": [
			{ "item_id": 1005, "color": "Gold", "size": 12, "stock_count": 1 },
		],
		"photos": [
			{ "color": "Gold", "photo_url": "https://i.ibb.co/g4MHQ9x/ua-mircogvalsetz-gold.webp" }
		]
	}
];

const backend_shoe_catalog = [
	{
		"item_id": 1001,
		"shoe_id": 1000,
		"color": "Black",
		"size": 7,
		"stock_count": 12,
		"brand": "Adidas",
		"model": "Breaknet 2.0",
		"price": 1099,
		"photo_url": "https://i.ibb.co/3S1WwKj/adidas-breaknet2-blackwhite.webp"
	}, {
		"item_id": 1000,
		"shoe_id": 1000,
		"color": "Black",
		"size": 6,
		"stock_count": 11,
		"brand": "Adidas",
		"model": "Breaknet 2.0",
		"price": 1099,
		"photo_url": "https://i.ibb.co/3S1WwKj/adidas-breaknet2-blackwhite.webp"
	}, {
		"item_id": 1002,
		"shoe_id": 1000,
		"color": "White",
		"size": 6,
		"stock_count": 5,
		"brand": "Adidas",
		"model": "Breaknet 2.0",
		"price": 1099,
		"photo_url": "https://i.ibb.co/JnxgLWL/adidas-breaknet2-whitebluered.webp"
	}, {
		"item_id": 1004,
		"shoe_id": 1001,
		"color": "Black",
		"size": 5,
		"stock_count": 5,
		"brand": "Nike",
		"model": "Air Max 90",
		"price": 2499,
		"photo_url": "https://i.ibb.co/hBkjfd7/nike-airmax90-black.webp"
	}, {
		"item_id": 1003,
		"shoe_id": 1001,
		"color": "Black",
		"size": 4,
		"stock_count": 3,
		"brand": "Nike",
		"model": "Air Max 90",
		"price": 2499,
		"photo_url": "https://i.ibb.co/hBkjfd7/nike-airmax90-black.webp"
	}, {
		"item_id": 1005,
		"shoe_id": 1002,
		"color": "Gold",
		"size": 12,
		"stock_count": 1,
		"brand": "Under Armour",
		"model": "Micro G Valsetz",
		"price": 2899,
		"photo_url": "https://i.ibb.co/g4MHQ9x/ua-mircogvalsetz-gold.webp"
	}
];