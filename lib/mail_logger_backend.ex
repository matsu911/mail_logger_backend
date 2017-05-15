defmodule MailLoggerBackend do
  @moduledoc """
  Documentation for MailLoggerBackend.
  """

  use Application
  alias MailLoggerBackend.{Pool, Formatter, Producer, Consumer}

  @doc false
  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    children = [
      worker(Producer, []),
      worker(Formatter, [10, 5]),
      worker(Consumer, [10, 5]),
      worker(Pool, [10])
    ]
    opts = [strategy: :one_for_one, name: MailLoggerBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc false
  def stop(_args) do
    # noop
  end
end
