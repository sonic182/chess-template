defmodule Chess.Movement do
  @moduledoc false

  require Logger

  def possible_movements(_player, board, {pos_x, pos_y} = position)
      when pos_x < 8 and pos_y < 8 and pos_x >= 0 and pos_y >= 0 do
    piece = get(board, position)
    Logger.debug("pos: #{inspect(position)}, piece: #{inspect(piece)}")

    movements(piece, board, position)
  end

  # def check?(player, board) do
  #   false
  # end

  defp get(board, {pos_x, pos_y}) do
    board |> Enum.at(pos_x) |> Enum.at(pos_y)
  end

  def movements(nil, _, _) do
    raise "no piece to move"
  end

  def movements(%{type: :pawn, color: color}, _board, {pos_x, pos_y}) do
    increment = if color == :white, do: -1, else: 1
    [{pos_x + increment, pos_y}]
  end

  def movements(%{type: :rook, color: color}, board, {pos_x, pos_y}) do
    # increment = if color == :white, do: -1, else: 1

    # iter row
    moves =
      0..8
      |> Enum.reduce_while([], fn iter_x, acc ->
        position = {iter_x, pos_y}

        if iter_x == pos_x do
          {:cont, acc}
        else
          target_movement_check(board, position, color, acc)
        end
      end)
      |> Enum.reverse()

    # iter cols
    moves2 =
      Enum.reduce_while(0..8, [], fn iter_y, acc ->
        position = {pos_x, iter_y}

        if iter_y == pos_y do
          {:cont, acc}
        else
          target_movement_check(board, position, color, acc)
        end
      end)
      |> Enum.reverse()

    moves ++ moves2
  end

  defp target_movement_check(board, position, player, acc) do
    case get(board, position) do
      nil -> {:cont, [position | acc]}
      %{color: ^player, type: _} -> {:halt, acc}
    end
  end
end
