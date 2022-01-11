import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :cross_commerce_desafio, CrossCommerceDesafio.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "cross_commerce_desafio_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cross_commerce_desafio, CrossCommerceDesafioWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "//tmaeCsJtsWbXnxnfLATxnynek4+wiGejq5OkvWvcxP53YTq3bI/nf+8RPNEuc7",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
