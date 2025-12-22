export default ({ env }) => ({
	connection: {
		client: 'mysql',
		connection: {
		host: env('DATABASE_HOST', '0.0.0.0'),
			port: env.int('DATABASE_PORT', 3306),
			database: env('DATABASE_NAME', 'strapi'),
			user: env('DATABASE_USERNAME', 'strapi'),
			password: env('DATABASE_PASSWORD', 'rootstrapi'),
			ssl: env.bool('DATABASE_SSL', false)
		}
	}
});
