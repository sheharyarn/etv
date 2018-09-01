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
      deps: deps()
    ]
  end


  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ETV.Data, []}
    ]
  end


  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto,      "~> 2.2.9"},
      {:ecto_rut,  "~> 1.2.2"},
      {:ecto_enum, "~> 1.1.0"},
      {:postgrex,  ">= 0.0.0"},
    ]
  end
end
