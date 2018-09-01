# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.



# Base App Configs
config :etv_data,
  ecto_repos: [ETV.Data.Repo]


# Ecto Configs
config :etv_data, ETV.Data.Repo,
  adapter:  Ecto.Adapters.Postgres,
  database: "etv_data_#{Mix.env}",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port:     "5432"





# Load Test-Specific Configs
if (Mix.env == :test) do
  import_config("test.exs")
end

