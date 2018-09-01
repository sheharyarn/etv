defmodule ETV.Web.PageView do
  use ETV.Web, :view


  def status(%{status: status}) do
    status =
      status
      |> to_string
      |> String.capitalize

    "[" <> status <> "]"
  end


  def hash(%{tx_hash: hash}) do
    hash
  end

end
