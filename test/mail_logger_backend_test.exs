defmodule MailLoggerBackendTest do
  use ExUnit.Case
  alias MailLoggerBackend.Formatter
  doctest MailLoggerBackend

  test "handle_events case 1" do
    data =
      ["#PID<0.111.0>", " running ", "Example.Endpoint", " terminated\n",
       [["Server: ", "localhost", ":", "4000", 32, 40, "http", 41, 10],
        ["Request: ", "GET", 32, "/api/test", 10]] | "data"]
    {:noreply, [{body}], _} =
      Formatter.handle_events([{{:error, data}}], nil, {})
    assert "#PID<0.111.0> running Example.Endpoint terminated\n\nServer: localhost:40003240http4110\nRequest: GET32/api/test10\ndata" == body
  end
end
