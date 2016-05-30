defmodule PhoenixTrello.BoardChannel.Monitor do
  use GenServer

  def start_link(initial_state) do
   GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def member_joined(board, member) do
   GenServer.call(__MODULE__, {:member_joined, board, member})
  end

  def member_left(board, member) do
    GenServer.call(__MODULE__, {:member_left, board, member})
  end

  def handle_call({:member_joined, board, member}, _from, state) do
    case Map.get(state, board) do
      nil ->
        state = state
        |> Map.put(board, [member])

        {:reply, [member], state}
      members ->
        state = state
        |> Map.put(board, Enum.uniq([member | members]))

        {:reply, Map.get(state, board), state}
    end
  end

  def handle_call({:member_left, board, member}, _from, state) do
    new_members = state
      |> Map.get(board)
      |> List.delete(member)

    state = state
      |> Map.update!(board, fn(_) -> new_members end)

    {:reply, new_members, state}
end

end
