# MailLoggerBackend

**An Elixir logger backend for notifying errors by mail.**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `mail_logger_backend` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:mail_logger_backend, "~> 0.1.0"}]
end
```

## Usage

This library uses Bamboo Mailer, so you can use adapters provided by Bamboo Mailer like as follows:

```elixir
config :mail_logger_backend, MailLoggerBackend.Mailer,
  adapter: Bamboo.SendgridAdapter,
  api_key: "API key"
```

Set mail subject, to and from addresses:

```elixir
config :mail_logger_backend,
  mail_subject: "Error in Sample App",
  mail_to: "user@example.com",
  mail_from: "noreply@example.com"
```

You can set the log levels you want mailed in the config:

```elixir
config MailLoggerBackend, :levels, [:debug, :info, :warn, :error]
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/mail_logger_backend](https://hexdocs.pm/mail_logger_backend).
