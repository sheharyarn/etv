defmodule ETV.Data.MixProject do
  use Mix.Project

  def project do
    [
      app: :etv_data,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env),
      deps: deps()
    ]
  end


  # Application
  def application do
    [
      extra_applications: [:logger],
      mod: {ETV.Data, []}
    ]
  end


  # Dependencies
  defp deps do
    [
      {:ecto,      "~> 2.2.9"},
      {:ecto_rut,  "~> 1.2.2"},
      {:ecto_enum, "~> 1.1.0"},
      {:postgrex,  ">= 0.0.0"},
    ]
  end


  # Compilation Paths
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

end
