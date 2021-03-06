defmodule Chatt.RoomChannel do
  use Chatt.Web, :channel

  def join("rooms:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("new:msg", msg, socket) do
    {room_id, _} = Integer.parse(msg["room_id"])
    message = %Chatt.Message{room_id: room_id, user: msg["user"], content: msg["body"]}
    {:ok, saved_message} = Chatt.Repo.insert(message)

    broadcast! socket, "new:msg", %{user: msg["user"], body: msg["body"], posted_at: saved_message.inserted_at}
    {:reply, {:ok, %{msg: msg["body"]}}, assign(socket, :user, msg["user"])}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (rooms:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # This is invoked every time a notification is being broadcast
  # to the client. The default implementation is just to push it
  # downstream but one could filter or change the event.
  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
