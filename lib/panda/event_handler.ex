defmodule Panda.EventHandler do
  @moduledoc """
  Defines a behaviour for building event handlers.
  """

  alias Panda.Event

  @callback init(Panda.Bot.t(), term()) :: {:ok, term()}
  @callback help() :: String.t()
  @callback handle_event(Event.t, term()) :: {:ok, term()}
end
