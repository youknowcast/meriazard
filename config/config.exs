# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :meriazard, MeriazardWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZwEV/NAb44IC4OV+//hFwq+8nVy01q8DJDyGzNOwm8mw+59rlSQF8vc7Rnv8ZLDp",
  live_view: [signing_salt: "i40QZdNBqUrMkmPyKASdqBkljPJkyPDh"],
  render_errors: [view: MeriazardWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Meriazard.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
