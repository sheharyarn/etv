defmodule ETV.Tracker.Application do
  use Application


  @moduledoc """
  Sub-Application Supervision Tree for :etv_tracker
  """


  # Supervision Tree
  # ----------------


  def start(_type, _args) do
    children = [
      ETV.Tracker.AutoUpdater,
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: __MODULE__)
  end

end
