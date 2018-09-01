defmodule ETV.Tracker.AutoUpdater do
  use GenServer
  require Logger


  @moduledoc """
  Periodically calls the Tracker.update_all/0 function
  after the specified time period.

  Ideally, this should be a Dynamic Supervisor that spawns
  new tasks for each of the Transactions that need to be
  updated.
  """

  @time_period 10_000 # ms



  # Public API
  # ----------

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end




  # Callbacks
  # ---------


  def init(:ok) do
    schedule_work()
    {:ok, :ok}
  end


  def handle_info(:work, state) do
    Logger.info("Updating status of unconfirmed transactions")

    spawn_link(&ETV.Tracker.update_all/0)
    schedule_work()

    {:noreply, state}
  end


  defp schedule_work() do
    Process.send_after(self(), :work, @time_period)
  end

end
