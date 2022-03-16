# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :google_meet_api,
  ecto_repos: [GoogleMeetApi.Repo]

# Configures the endpoint
config :google_meet_api, GoogleMeetApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9iXSIaNzI3MskGhPXiwXrCln5oveQQ20WEDOESlKvDf62yHNm5UuTy9Q6kwqRnsP",
  render_errors: [view: GoogleMeetApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: GoogleMeetApi.PubSub,
  live_view: [signing_salt: "6s50da4g"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
