defmodule ETV.Data do
  use Application


  @moduledoc """
  ETV Sub-Application responsible for connecting to
  data repos and writing/reading data.
  """



  # Supervision Tree
  # ----------------


  @doc "Start the Application"
  def start(_type, _args) do
    children = [
      ETV.Data.Repo,
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: __MODULE__)
  end


end
