defmodule ETV.Network.MixProject do
  use Mix.Project

  def project do
    [
      app: :etv_network,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixirc_paths: elixirc_paths(Mix.env),
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end


  # Application
  def application do
    [extra_applications: [:logger]]
  end


  # Dependencies
  defp deps do
    [
      {:httpoison, "~> 1.2.0"},
      {:jason,     "~> 1.1.0"},
      {:bypass,    "~> 0.8", only: :test},
    ]
  end


  # Compilation Paths
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

end
