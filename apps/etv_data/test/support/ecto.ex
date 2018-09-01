defmodule Tests.Support.Ecto do
  @moduledoc """
  Ecto Support Helpers for Tests
  """


  def setup(tags) do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(ETV.Data.Repo)
    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(ETV.Data.Repo, {:shared, self()})
    end
    :ok
  end

end


