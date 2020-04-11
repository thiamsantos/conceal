defmodule Conceal.MixProject do
  use Mix.Project

  def project do
    [
      app: :conceal,
      version: "0.1.1",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Easy encrypt data with AES-CBC-256",
      package: package(),
      name: "Conceal",
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      maintainers: ["Thiago Santos"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/thiamsantos/conceal"}
    ]
  end

  defp docs do
    [
      main: "Conceal",
      source_url: "https://github.com/thiamsantos/conceal"
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.21.3", only: :dev, runtime: false}
    ]
  end
end
