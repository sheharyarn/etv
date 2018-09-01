defmodule ETV.Network do
  @moduledoc """
  Application responsible for connecting to external APIs,
  and fetching information.

  Currently the only external API being used is that of
  Ethplorer (all ethplorer-specific logic inside its own
  context), but we can easily swap it with another API
  if we wanted to.
  """

  @adapter ETV.Network.Ethplorer




  # Public API
  # ----------

  defdelegate tx_info(hash),  to: @adapter


end
