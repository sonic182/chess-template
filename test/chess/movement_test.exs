defmodule Chess.MovementTest do
  use ExUnit.Case

  alias Chess.Dashboard
  alias Chess.Movement
  alias Chess.Piece

  test "[pawn] retrieve possible_movements" do
    expected = [{2, 0}]
    player = :white
    board = Dashboard.new()

    assert expected == Movement.possible_movements(player, board, {1, 0})
  end

  test "[rook] retrieve possible_movements default dashboard" do
    piece_pos = [{0, 0}]
    expected = []
    player = :black
    board = Dashboard.new()

    assert expected == Movement.possible_movements(player, board, {0, 0})
  end

  test "[rook] retrieve possible_movements" do
    board = null_dashboard()
    piece = Piece.new(:rook)
    position = {3, 3}
    board = put_in_board(board, piece, position)

    expected = [
      {0, 3},
      {1, 3},
      {2, 3},
      {4, 3},
      {5, 3},
      {6, 3},
      {7, 3},
      {8, 3},
      {3, 0},
      {3, 1},
      {3, 2},
      {3, 4},
      {3, 5},
      {3, 6},
      {3, 7},
      {3, 8}
    ]

    player = :black

    assert expected == Movement.possible_movements(player, board, position)
  end

  defp null_dashboard() do
    for _ <- 0..8 do
      Enum.map(0..8, fn _ -> nil end)
    end
  end

  defp put_in_board(board, piece, {pos_x, pos_y}) do
    row = Enum.at(board, pos_x)
    new_col = List.insert_at(row, pos_y, piece)
    List.insert_at(board, pos_x, new_col)
  end
end
