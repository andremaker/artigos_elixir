defmodule KV.MixProject do
  use Mix.Project

  def project do
    [
      app: :regevents,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:json, "~> 1.2"},
      {:jason, "~> 1.1"},
      {:mariaex, "~> 0.9",override: true},
      {:myxql, "~> 0.3.1",override: true},
      {:plug_cowboy, "~> 2.0"},
      {:guardian, "~> 2.0"},
      {:cowboy, "~> 2.5.0"},
      {:plug, "~> 1.0"},
      {:sqlite_ecto, "~> 1.0.0"},
      {:ecto, "~> 1.0",override: true},
      {:decimal, "~> 1.8.1", override: true}
    ]
  end
  
end
