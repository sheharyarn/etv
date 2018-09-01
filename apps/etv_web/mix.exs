defmodule ETV.Web.Mixfile do
  use Mix.Project


  def project do
    [
      app: :etv_web,
      version: "0.0.1",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end


  # Application
  def application do
    [
      mod: {ETV.Web.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end


  # Dependencies
  defp deps do
    [
      {:cowboy,               "~> 1.0"},
      {:gettext,              "~> 0.11"},
      {:phoenix,              "~> 1.3.2"},
      {:phoenix_pubsub,       "~> 1.0"},
      {:phoenix_html,         "~> 2.10"},
      {:phoenix_live_reload,  "~> 1.0", only: :dev},

      {:etv_data, in_umbrella: true},
    ]
  end


  # Aliases
  defp aliases do
    []
  end


  # Compilation Paths
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

end
