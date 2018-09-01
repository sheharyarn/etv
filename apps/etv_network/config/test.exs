use Mix.Config


# Localhost for testing mock requests
config :etv_network, :ethplorer,
  host: "http://localhost:58585"


# Specify same port to Bypass
config :bypass,
  port: 58585


