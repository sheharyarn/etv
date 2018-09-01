defmodule ETV.Data.Repo.Schema do

  @moduledoc """
  Custom Macro for initializing Ecto Schemas with
  sane defaults
  """

  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema
      use Ecto.Rut, repo: ETV.Data.Repo

      import  Ecto.Changeset
      require Ecto.Query

      alias Ecto.Query
      alias ETV.Data.Repo
      alias ETV.Data.Repo.Enums
    end
  end

end

