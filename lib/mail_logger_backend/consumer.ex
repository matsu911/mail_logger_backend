defmodule MailLoggerBackend.Consumer do

  @moduledoc """
  Consumes logger events and pushes them onto the worker pool to send to Slack.
  """
  use GenStage
  alias MailLoggerBackend.{Formatter, Pool}

  @doc false
  def start_link(max_demand, min_demand) do
    GenStage.start_link(__MODULE__, {max_demand, min_demand}, name: __MODULE__)
  end

  @doc false
  def init({max_demand, min_demand}) do
    {:consumer, %{},
     subscribe_to: [{Formatter, max_demand: max_demand, min_demand: min_demand}]}
  end

  @doc false
  def handle_events([], _from, interval) do
    process_events([], interval)
  end

  @doc false
  def handle_events(events, _from, state) do
    events
    |> Enum.filter(fn evt -> evt != :empty end)
    |> process_events(state)
  end

  defp process_events([], state) do
    {:noreply, [], state}
  end

  defp process_events([{data}|events], state) do
    Pool.post(data)
    process_events(events, state)
  end

end
