defmodule Panda.Handlers.Echo do
  @moduledoc false
  use Panda.Listener

  @help """
  panda echome <text> - Echos the text back to you
  """

  respond ~r/echome (.*)/, fn [match], event ->
    reply(event, match)
  end

  @help """
  echo <text> - Echos the text back to the channel
  """

  hear ~r/^echo (.*)/, fn [match], event ->
    say(event, match)
  end

  @help """
  echocode <text> - Echos the text back to the channel as code
  """
  hear ~r/^echocode (.*)/, fn [match], event ->
    code(event, match)
  end
end
