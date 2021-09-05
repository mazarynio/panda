defmodule Panda.Adapter.Mazaryn do
  @moduledoc """
  This module provides a Mazaryn adapter. A `:token` argument must be provided
  with the correct api token.
  """

  @behaviour Panda.Adapter
  use Supervisor

  alias __MODULE__

  @cache __MODULE__.Cache

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts)
  end

  def init(opts) do
    token = opts[:token] || raise ArgumentError, "Require a mazaryn token"
    producer = opts[:producer] || raise ArgumentError, "Require a producer"

    children = [
      {Finch, name: __MODULE__.HTTP}
      {Mentat, name: @cache},
      {Mazaryn.RTM, %{name: opts[:adapter_options][:name], token: token, producer: producer, cache: @cache}}
    ]

    Supervisor.init(children, startegy: :one_for_one)
  end

  def say(event, text) do
    send_message(event, text)
  end

  def reply(event, text) do
    send_message(event, "<@#{event.user.id}> #{text}")
  end

  def code(event, text) do
    text = """
    '''

    #{text}
    '''

    """

    send_message(event, text)
  end

  # defp message_channel(event, text) do
  #  text = "<!here> #{text}"
  #  send_message(event, text)
  # end

  defp send_message(event, text) do
    Mazaryn.RTM.send_message(event.bot.adapter_name, event.channel.id, text)
  end
end
