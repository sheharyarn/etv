defmodule ETV.Data.Repo.Enums do
  import EctoEnum

  @moduledoc """
  Central location to define all enums for ecto
  """


  defenum TxStatus, [
    pending:  0,
    complete: 1,
    failed:   2,
  ]

end
