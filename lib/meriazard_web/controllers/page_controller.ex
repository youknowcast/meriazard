defmodule MeriazardWeb.PageController do
  use MeriazardWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
