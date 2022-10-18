defmodule Chess.Movement do
  @moduledoc false

  @horse_posibilities [{1, 2}, {1, -2}, {-1, 2}, {-1, -2}, {2, 1}, {-2, 1}, {2, -1}, {-2, -1}]

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

  def movements(nil, _, position) do
    raise "no piece to move in pos #{inspect(position)}"
  end

  def movements(%{type: :pawn, color: color}, _board, {pos_x, pos_y}) do
    increment = if color == :white, do: -1, else: 1
    [{pos_x + increment, pos_y}]
  end

  def movements(%{type: :rook, color: color}, board, my_position) do
    get_line_moves(board, my_position, color)
  end

  def movements(%{type: :bishop, color: color}, board, my_position) do
    get_diagonal_moves(board, my_position, color)
  end

  def movements(%{type: :knight, color: color}, board, my_position) do
    get_knight_moves(board, my_position, color)
  end

  defp get_knight_moves(board, {pos_x, pos_y}, color) do
    @horse_posibilities
    |> Enum.map(fn {x, y} -> {pos_x + x, pos_y + y} end)
    |> Enum.reject(fn {x, y} -> x > 7 or x < 0 or y > 7 or y < 0 end)
    |> Enum.filter(fn position ->
      case movement_action(board, position, color) do
        :move -> true
        :eat -> true
        :blocked -> false
      end
    end)
  end

  defp get_line_moves(board, {pos_x, pos_y} = my_position, color) do
    moves1 = line_iter(board, my_position, color, pos_x..7, :row)
    moves2 = line_iter(board, my_position, color, pos_x..0, :row)
    moves3 = line_iter(board, my_position, color, pos_y..7, :col)
    moves4 = line_iter(board, my_position, color, pos_y..0, :col)

    moves1 ++ moves2 ++ moves3 ++ moves4
  end

  def line_iter(board, {pos_x, pos_y} = my_position, color, range, type_iter) do
    range
    |> Enum.map(fn id ->
      if type_iter == :row do
        {id, pos_y}
      else
        {pos_x, id}
      end
    end)
    |> Enum.reject(&Kernel.==(&1, my_position))
    |> Enum.reduce_while([], fn position, acc ->
      case movement_action(board, position, color) do
        :move -> {:cont, [position | acc]}
        :eat -> {:halt, [position | acc]}
        :blocked -> {:halt, acc}
      end
    end)
    |> Enum.reverse()
  end

  defp get_diagonal_moves(board, my_position, color) do
    moves1 = diagonal_iter(board, my_position, color, :up_right, my_position)
    moves2 = diagonal_iter(board, my_position, color, :up_left, my_position)
    moves3 = diagonal_iter(board, my_position, color, :down_right, my_position)
    moves4 = diagonal_iter(board, my_position, color, :down_left, my_position)

    moves1 ++ moves2 ++ moves3 ++ moves4
  end

  def diagonal_iter(_board, {pos_x, pos_y}, _color, _type, _my_position)
      when pos_x > 7 or pos_x < 0 or pos_y > 7 or pos_y < 0 do
    []
  end

  def diagonal_iter(board, my_pos, player, type, original_pos) when my_pos == original_pos do
    new_pos = get_next_pos_diagonal(my_pos, type)
    diagonal_iter(board, new_pos, player, type, original_pos)
  end

  def diagonal_iter(board, my_pos, player, type, original_pos) do
    case movement_action(board, my_pos, player) do
      :move ->
        new_pos = get_next_pos_diagonal(my_pos, type)
        positions = diagonal_iter(board, new_pos, player, type, original_pos)

        [my_pos | positions]

      :eat ->
        [my_pos]

      :blocked ->
        []
    end
  end

  defp get_next_pos_diagonal({x, y}, :up_right), do: {x + 1, y + 1}
  defp get_next_pos_diagonal({x, y}, :up_left), do: {x + 1, y - 1}
  defp get_next_pos_diagonal({x, y}, :down_right), do: {x - 1, y + 1}
  defp get_next_pos_diagonal({x, y}, :down_left), do: {x - 1, y - 1}

  defp movement_action(board, position, actual_player) do
    case get(board, position) do
      nil -> :move
      %{color: ^actual_player, type: _} -> :blocked
      %{color: _, type: _} -> :eat
    end
  end
end
