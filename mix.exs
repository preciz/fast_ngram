defmodule FastNgram.MixProject do
  use Mix.Project

  @version "1.0.0"
  @github "https://github.com/preciz/fast_ngram"

  def project do
    [
      app: :fast_ngram,
      version: @version,
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package(),
      name: "FastNgram",
      description: "A fast and unicode aware letter & word N-gram library written in Elixir."
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
    ]
  end

  defp package do
    [
      maintainers: ["Barna Kovacs"],
      licenses: ["MIT"],
      links: %{"GitHub" => @github}
    ]
  end

  defp docs do
    [
      main: "FastNgram",
      source_ref: "v#{@version}",
      source_url: @github,
    ]
  end
end
