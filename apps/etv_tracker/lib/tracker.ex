defmodule ETV.Tracker do
  alias ETV.Network
  alias ETV.Data.Transaction



  @moduledoc """
  Exposes two methods which look in the local DB for all
  transactions not marked confirmed. Then checks the no. of
  confirmations for each of those transactions against an
  external API, and marks them "complete" if the numbere is
  more than the threshold specified.

  Between updating the information between transactions, it
  waits for the time period specified as to not get blocked
  by the external API by rate-limits.
  """

  @confirmation_threshold 2
  @wait_between_requests  1000 # ms




  # Public API
  # ----------


  @doc "Updates information about unconfirmed transactions"
  def update_all do
    Enum.each(Transaction.unconfirmed, &update_tx/1)
  end



  @doc "Update information for given tx"
  def update_tx(%Transaction{tx_hash: hash} = tx, wait \\ true) do
    if wait do
      Process.sleep(@wait_between_requests)
    end

    with {:ok, info} <- Network.tx_info(hash) do
      case (info.confirmations >= @confirmation_threshold) do
        false ->
          {:error, :unconfirmed}

        true ->
          Transaction.update(tx, status: :complete)
      end
    end
  end


end
