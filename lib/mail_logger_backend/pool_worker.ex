defmodule MailLoggerBackend.PoolWorker do

  @moduledoc """
  A message pool worker.
  """

  use GenServer
  alias MailLoggerBackend.{Mailer}

  @doc false
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], [])
  end

  @doc false
  def init(state) do
    {:ok, state}
  end

  @doc false
  def handle_call({:post, body}, _from, worker_state) do
    result = Mailer.send_mail(body)
    {:reply, result, worker_state}
  end

  @doc """
  Gets a message.
  """
  def post(pid, body) do
    GenServer.call(pid, {:post, body}, :infinity)
  end

end
