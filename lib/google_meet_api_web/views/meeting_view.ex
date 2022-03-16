defmodule GoogleMeetApiWeb.MeetingView do
  use GoogleMeetApiWeb, :view
  alias GoogleMeetApiWeb.MeetingView


  def render("error.json", %{message: message}) do
    %{
      status: false,
      message: message
    }
  end



  def render("success.json", %{message: message}) do
    # When encoded, the changeset returns its errors
    # as a JSON object. So we just pass it forward.
    %{
      status: true,
      message: message
     }
  end
end
