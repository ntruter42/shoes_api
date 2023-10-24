import app_setup from "./config/app.js";
import db_config from "./config/database.js";
import database_services from "./services/database_services.js";
import catalog_services from "./services/catalog_services.js";
import catalog_routes from "./routes/catalog_routes.js";
import { shoes_api } from "./routes/catalog_api.js";
import { carts_api } from "./routes/catalog_api.js";

const app = app_setup();
const db = db_config();
const catalog = catalog_services();
const services = database_services(db);

app.use('/', catalog_routes);
app.use('/api/shoes', shoes_api);
app.use('/api/cart', carts_api);

export { services, catalog };

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
	console.log(`http://localhost:${PORT}`);
});