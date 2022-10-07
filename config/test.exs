import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :chess, ChessWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "2PABQyNOrXJFFPfe9zJDiX/1o3O9xM8bj7cQVnbLLLdEK1GHJQ4Yzj2V4pcAUeWF",
  server: false

# In test we don't send emails.
config :chess, Chess.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
