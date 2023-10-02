import app_setup from "./config/app.js";
import db_config from "./config/database.js";
import catalog_api from "./routes/catalog_api.js";
import catalog_services from "./services/catalog_services.js";
import catalog_routes from "./routes/catalog_routes.js";

const app = app_setup();
const db = db_config();
const services = catalog_services(db);

app.use('/', catalog_routes);
app.use('/api', catalog_api);

export { services };

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
	console.log(`http://localhost:${PORT}`);
});