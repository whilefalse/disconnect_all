defmodule DisconnectAllWeb.PageController do
  use DisconnectAllWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
