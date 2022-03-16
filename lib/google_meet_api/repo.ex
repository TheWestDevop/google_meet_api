defmodule GoogleMeetApi.Repo do
  use Ecto.Repo,
    otp_app: :google_meet_api,
    adapter: Ecto.Adapters.Postgres
end
