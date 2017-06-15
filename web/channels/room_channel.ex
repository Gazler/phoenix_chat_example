defmodule Chat.RoomChannel do
  use Phoenix.Channel
  require Logger

  @doc """
  Authorize socket to subscribe and broadcast events on this channel & topic

  Possible Return Values

  `{:ok, socket}` to authorize subscription for channel for requested topic

  `:ignore` to deny subscription/broadcast on this channel
  for the requested topic
  """
  def join("rooms:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("rooms:" <> _channel, _message, socket) do
    {:ok, socket}
  end

  def terminate(reason, _socket) do
    Logger.debug"> leave #{inspect reason}"
    :ok
  end

  def handle_in("new:msg", msg, socket) do
    broadcast_from!(socket, "new:msg", %{sent_at: msg["sent_at"]})
    {:reply, :ok, socket}
  end
end
