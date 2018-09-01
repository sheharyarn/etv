defmodule ETV.Web.PageController do
  use ETV.Web, :controller

  alias ETV.Data.Transaction
  alias ETV.Web.PageView


  def index(conn, _params) do
    txs = Transaction.all
    render(conn, "index.html", txs: txs)
  end


  def create(conn, %{"hash" => hash}) do
    hash = String.trim(hash)
    case Transaction.getsert(hash) do
      {:ok, tx} ->
        conn
        |> put_flash(:info, "Transaction Status is: #{PageView.status(tx)}")
        |> redirect(to: page_path(conn, :index))

      {:error, reason} ->
        conn
        |> put_flash(:error, render_errors(reason))
        |> redirect(to: page_path(conn, :index))
    end
  end



  # Private
  # -------

  defp render_errors(%Ecto.Changeset{errors: errors}) do
    errors = for {key, {message, _}} <- errors do
      "#{key} #{message}"
    end
  end

  defp render_errors({context, reason}) do
    "#{context}: #{reason}"
  end

  defp render_errors(reason) do
    inspect(reason)
  end

end
