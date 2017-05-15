defmodule MailLoggerBackend.Formatter do

  @moduledoc """
  Formats log events into pretty mail body.
  """

  use GenStage
  alias MailLoggerBackend.{Producer}

  @doc false
  def start_link(max_demand, min_demand) do
    GenStage.start_link(__MODULE__, {max_demand, min_demand}, name: __MODULE__)
  end

  @doc false
  def init({max_demand, min_demand}) do
    {:producer_consumer, %{},
     subscribe_to: [{Producer, max_demand: max_demand, min_demand: min_demand}]}
  end

  @doc false
  def handle_events(events, _from, state) do
    events = Enum.map(events, &format_event/1)
    {:noreply, events, state}
  end

  defp format_event({{:error, [a, b, c, d, [server, request] | stacktrace]}}) do
    {a <> b <> c <> d <> "\n" <>
    (server |> Enum.join) <> "\n" <>
    (request |> Enum.join) <> "\n" <>
      stacktrace}
  end

  defp format_event({{:error, data}}) do
    {inspect data}
  end

  defp format_event({data}) do
    {inspect data}
  end

end
