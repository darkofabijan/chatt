defmodule Chatt.PageController do
  use Chatt.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
