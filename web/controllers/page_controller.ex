defmodule TemariosApi.PageController do
  use TemariosApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
