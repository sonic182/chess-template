defmodule Chess.MovementRookTest do
  use ExUnit.Case

  alias Chess.Dashboard
  alias Chess.Movement
  alias Chess.Piece

  import Chess.TestHelper, only: [null_dashboard: 0, put_in_board: 3]

  test "[rook] retrieve possible_movements default dashboard" do
    piece_pos = {0, 0}
    expected = []
    player = :black
    board = Dashboard.new()

    assert expected == Movement.possible_movements(player, board, piece_pos)
  end

  test "[rook] retrieve possible_movements, rook alone" do
    board = null_dashboard()
    piece = Piece.new(:rook)
    position = {3, 3}
    board = put_in_board(board, piece, position)

    expected = [
      {4, 3},
      {5, 3},
      {6, 3},
      {7, 3},
      {2, 3},
      {1, 3},
      {0, 3},
      {3, 4},
      {3, 5},
      {3, 6},
      {3, 7},
      {3, 2},
      {3, 1},
      {3, 0}
    ]

    player = :black

    assert expected == Movement.possible_movements(player, board, position)
  end

  test "[rook] retrieve possible_movements rock vs pawn " do
    piece = Piece.new(:rook)
    position = {3, 3}

    piece2 = Piece.new(:pawn, :black)
    position2 = {3, 5}

    board =
      null_dashboard()
      |> put_in_board(piece, position)
      |> put_in_board(piece2, position2)

    expected = [
      {4, 3},
      {5, 3},
      {6, 3},
      {7, 3},
      {2, 3},
      {1, 3},
      {0, 3},
      {3, 4},
      {3, 5},
      {3, 2},
      {3, 1},
      {3, 0}
    ]

    player = :black

    assert expected == Movement.possible_movements(player, board, position)
  end

  test "[rook] retrieve possible_movements empty board, rook in edge" do
    piece = Piece.new(:rook)
    position = {7, 7}

    piece2 = Piece.new(:pawn, :black)
    position2 = {7, 5}

    board =
      null_dashboard()
      |> put_in_board(piece, position)
      |> put_in_board(piece2, position2)

    expected = [
      {6, 7},
      {5, 7},
      {4, 7},
      {3, 7},
      {2, 7},
      {1, 7},
      {0, 7},
      {7, 6},
      {7, 5}
    ]

    player = :black

    assert expected == Movement.possible_movements(player, board, position)
  end
end
