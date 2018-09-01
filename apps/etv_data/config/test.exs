use Mix.Config


# Ecto: Pool/Adapters
config :etv_data, ETV.Data.Repo,
  pool: Ecto.Adapters.SQL.Sandbox


# Don't print debug messages
config :logger,
  level: :info

