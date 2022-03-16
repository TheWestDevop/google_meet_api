defmodule GoogleMeetApiWeb.MeetingController do
  use GoogleMeetApiWeb, :controller

  action_fallback(GoogleMeetApiWeb.FallbackController)

#   def get_access_token(conn, params) do
#     with {:ok, better_params} <-
#            Tarams.cast(
#              %{
#                "channel_name" => params["channel_name"]
#              },
#              %{
#                user_id: [type: :string, length: [min: 32], required: true],
#                channel_name: [type: :string, required: true]
#              }
#            ) do
#       token = generate_agora_token(better_params.channel_name)

#       conn
#       |> put_status(200)
#       |> put_resp_header("content-type", "application/json; charset=utf-8")
#       |> render("success.json", message: token)
#     else
#       {:error, error} -> 
#         conn 
#         |> put_status(:bad_request) 
#         |> render("error.json", message: error)
#     end
#   end
def generate_token(conn, params) do
    with {:ok, better_params} <-
           Tarams.cast(
             %{
               "channel_name" => params["channel_name"]
             },
             %{
               channel_name: [type: :string, required: true]
             }
           ) do
      token = generate_agora_token(better_params.channel_name)

      conn
      |> put_status(200)
      |> put_resp_header("content-type", "application/json; charset=utf-8")
      |> render("success.json", message: token)
    else
      {:error, error} -> conn |> put_status(:bad_request) |> render("error.json", message: error)
    end
  end


  @app_certificate "0d5e4e3e1a2e48f297daa35bb2e617b8"
  @app_id "23912278be2d4b0b850852ea04fb1e6b"

  defp generate_agora_token(channel_name) do
    Agora.AccessKey.new_token(@app_id, @app_certificate, channel_name, "0", [
      :join_channel,
      :publish_audio,
      :publish_video,
      :request_publish_audio,
      :request_publish_video
    ])
  end
end
