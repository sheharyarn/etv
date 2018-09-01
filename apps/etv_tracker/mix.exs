defmodule ETV.Tracker.MixProject do
  use Mix.Project

  def project do
    [
      app: :etv_tracker,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end


  # Application
  def application do
    [
      extra_applications: [:logger],
      #mod: {ETV.Tracker.Application, []}
    ]
  end


  # Dependencies
  defp deps do
    [
      {:etv_data,    in_umbrella: true},
      {:etv_network, in_umbrella: true},
    ]
  end
end
