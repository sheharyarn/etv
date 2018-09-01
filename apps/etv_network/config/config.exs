# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config


# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.


# Ethplorer Client Configs
config :etv_network, :ethplorer,
  host: "http://api.ethplorer.io/",
  api_key: (System.get_env("API_KEY_ETHPLORER") || "freekey")




# Load Test-Specific Configs
if (Mix.env == :test) do
  import_config("test.exs")
end

