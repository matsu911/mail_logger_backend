defmodule MailLoggerBackend.Mixfile do
  use Mix.Project

  def project do
    [app: :mail_logger_backend,
     description: "An Elixir logger backend for notifying errors by mail.",
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     packages: package()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger],
     mod: {MailLoggerBackend, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:gen_stage, "~> 0.11"},
      {:poolboy, "~> 1.5.1"},
      {:bamboo, "~> 0.8"},
      {:ex_doc, "~> 0.15", only: :dev, runtime: false},
      {:credo, "~> 0.7", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*"],
      licenses: ["MIT"],
      maintainers: ["Shigeaki Matsumura"],
      links: %{"Github" => "https://github.com/matsu911/mail_logger_backend"}
    ]
  end
end
