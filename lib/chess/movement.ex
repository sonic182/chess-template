defmodule Chess.Movement do
  @moduledoc false

  @king_posibilities [
    {1, 1},
    {1, -1},
    {-1, 1},
    {-1, -1},
    {1, 0},
    {-1, 0},
    {0, 1},
    {0, -1}
  ]
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

  def movements(%{type: :pawn, color: player}, board, my_position) do
    get_pawn_moves(board, my_position, player)
  end

  def movements(%{type: :rook, color: player}, board, my_position) do
    get_line_moves(board, my_position, player)
  end

  def movements(%{type: :bishop, color: player}, board, my_position) do
    get_diagonal_moves(board, my_position, player)
  end

  def movements(%{type: :knight, color: player}, board, my_position) do
    get_knight_moves(board, my_position, player)
  end

  def movements(%{type: :queen, color: player}, board, my_position) do
    get_line_moves(board, my_position, player) ++ get_diagonal_moves(board, my_position, player)
  end

  def movements(%{type: :king, color: player}, board, my_position) do
    get_king_moves(board, my_position, player)
  end

  def get_pawn_moves(board, {pos_x, pos_y} = my_position, player) do
    increment = if player == :white, do: -1, else: 1
    normal_move = {pos_x + increment, pos_y}
    possible_eats = [{pos_x + increment, pos_y + 1}, {pos_x + increment, pos_y - 1}]

    resp =
      if movement_action(board, normal_move, player) == :blocked do
        []
      else
        [normal_move]
      end

    possible_eats
    |> Enum.filter(fn position ->
      movement_action(board, position, player) == :eat
    end)
    |> Enum.concat(resp)
    |> Enum.sort()
  end

  defp get_king_moves(board, my_pos, player) do
    get_movements_by_posibilities(board, my_pos, player, @king_posibilities)
  end

  defp get_knight_moves(board, my_pos, player) do
    get_movements_by_posibilities(board, my_pos, player, @horse_posibilities)
  end

  defp get_movements_by_posibilities(board, {pos_x, pos_y}, player, posibilities) do
    posibilities
    |> Enum.map(fn {x, y} -> {pos_x + x, pos_y + y} end)
    |> Enum.reject(&invalid_position?/1)
    |> Enum.filter(fn position ->
      case movement_action(board, position, player) do
        :move -> true
        :eat -> true
        :blocked -> false
      end
    end)
  end

  defp get_line_moves(board, {pos_x, pos_y} = my_position, player) do
    moves1 = line_iter(board, my_position, player, pos_x..7, :row)
    moves2 = line_iter(board, my_position, player, pos_x..0, :row)
    moves3 = line_iter(board, my_position, player, pos_y..7, :col)
    moves4 = line_iter(board, my_position, player, pos_y..0, :col)

    res = moves1 ++ moves2 ++ moves3 ++ moves4
    Enum.sort(res)
  end

  def line_iter(board, {pos_x, pos_y} = my_position, player, range, type_iter) do
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
      case movement_action(board, position, player) do
        :move -> {:cont, [position | acc]}
        :eat -> {:halt, [position | acc]}
        :blocked -> {:halt, acc}
      end
    end)
    |> Enum.reverse()
  end

  defp get_diagonal_moves(board, my_position, player) do
    moves1 = diagonal_iter(board, my_position, player, :up_right, my_position)
    moves2 = diagonal_iter(board, my_position, player, :up_left, my_position)
    moves3 = diagonal_iter(board, my_position, player, :down_right, my_position)
    moves4 = diagonal_iter(board, my_position, player, :down_left, my_position)

    moves1 ++ moves2 ++ moves3 ++ moves4
  end

  def diagonal_iter(_board, {pos_x, pos_y}, _player, _type, _my_position)
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

  defp invalid_position?({x, y}), do: x > 7 or x < 0 or y > 7 or y < 0
end
