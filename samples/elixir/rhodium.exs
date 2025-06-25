# rhodium.exs
# This is a test for Elixir linters and language servers.

defmodule Rhodium do
  def greet do
    message = "Welcome to Rhodium"
    IO.puts(message)
  end
end

Rhodium.greet()
