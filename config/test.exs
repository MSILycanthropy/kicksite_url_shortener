import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :kicksite_url_shortener, KicksiteUrlShortener.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "kicksite_url_shortener_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :kicksite_url_shortener, KicksiteUrlShortenerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Bi45KTnhljgLqwK/Ir6Xvtmy9VCmo5PM2NRneEh/CiZfFAGT+dR6BJuKxCrwzkOS",
  server: false

# In test we don't send emails.
config :kicksite_url_shortener, KicksiteUrlShortener.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
