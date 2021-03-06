defmodule PhoenixTrello.CurrentUserController do
  use PhoenixTrello.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: PhoenixTrello.SessionController

  def show(conn, _params) do
    conn
    |> put_status(:ok)
    |> render("show.json", user: Guardian.Plug.current_resource(conn))
  end
end
