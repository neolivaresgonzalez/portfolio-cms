export default ({ env }) => ({
  host: env('HOST', '0.0.0.0'),
  port: env.int('PORT', 1337),
  // Public URL for the application (required for admin panel behind proxy)
  url: env('PUBLIC_URL', 'https://cms.neolivaresgonzalez.com'),
  proxy: env.bool('IS_PROXY', true),
  app: {
    keys: env.array('APP_KEYS'),
  },
});
