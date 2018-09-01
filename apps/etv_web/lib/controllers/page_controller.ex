defmodule ETV.Web.PageController do
  use ETV.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
