defmodule Panda.Adapter do
  @moduledoc """
  Defines a behaviour for adapters for different chat applications.
  """

  @type event :: Panda.Event.t()

  @callback say(event(), binary()) :: term()
  @callback reply(event(), binary()) :: term()
  @callback code(event(), binary()) :: term()
end
