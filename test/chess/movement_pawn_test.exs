defmodule Chess.MovementPawnTest do
  use ExUnit.Case

  alias Chess.Dashboard
  alias Chess.Movement
  alias Chess.Piece

  import Chess.TestHelper, only: [null_dashboard: 0, put_in_board: 3]

  test "[pawn] retrieve possible_movements default dashboard" do
    piece_pos = {1, 3}
    expected = [{2, 3}]
    player = :black
    board = Dashboard.new()

    assert expected == Movement.possible_movements(player, board, piece_pos)
  end

  test "[pawn] retrieve possible_movements, pawn alone" do
    board = null_dashboard()
    piece = Piece.new(:pawn)
    position = {3, 3}
    board = put_in_board(board, piece, position)

    expected = [{2, 3}]

    player = :black

    assert expected == Movement.possible_movements(player, board, position)
  end

  test "[pawn] retrieve possible_movements, pawn eating" do
    piece = Piece.new(:pawn)
    position = {3, 3}

    piece2 = Piece.new(:pawn, :black)
    position2 = {2, 2}

    piece3 = Piece.new(:pawn, :black)
    position3 = {2, 4}

    board =
      null_dashboard()
      |> put_in_board(piece, position)
      |> put_in_board(piece2, position2)
      |> put_in_board(piece3, position3)

    expected = [{2, 2}, {2, 3}, {2, 4}]

    player = :black

    assert expected == Movement.possible_movements(player, board, position)
  end
end
