defmodule ETV.Network.Ethplorer do
  alias ETV.Network.Ethplorer

  @moduledoc """
  Elixir Interface to the Ethplorer API for the Ethereum
  Blockchain.
  """


  @http_options [
    hackney: [follow_redirect: true],
  ]




  # Public API
  # ----------


  def tx_info(tx_hash) do
    "/getTxInfo/#{tx_hash}"
    |> Ethplorer.Request.build_url
    |> HTTPoison.get([], @http_options)
    |> Ethplorer.Request.handle_response
  end


end
