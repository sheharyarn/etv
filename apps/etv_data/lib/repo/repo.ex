defmodule ETV.Data.Repo do
  use Ecto.Repo, otp_app: :etv_data


  @moduledoc """
  The Module responsible for reading/writing data. Currently,
  this data is being stored to an external database via Ecto,
  but we can easily swap ecto to use Mnesia or some other
  server or database.
  """

end
