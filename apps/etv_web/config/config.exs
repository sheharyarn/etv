# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :etv_web,
  namespace: ETV.Web

# Configures the endpoint
config :etv_web, ETV.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eLdsACVKQJRjxPL73oq6wIAmWJbMFRH3hBPCMOnKuwiwqrwbj58SMjuaPRFJQC/E",
  render_errors: [view: ETV.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ETV.Web.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :etv_web, :generators,
  context_app: :etv

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
