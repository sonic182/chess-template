defmodule Chess.Dashboard do
  @moduledoc false

  alias Chess.Piece

  def new do
    default_board()
  end

  def default_board() do
    [
      [
        piece_b(:rook),
        piece_b(:knight),
        piece_b(:bishop),
        piece_b(:queen),
        piece_b(:king),
        piece_b(:bishop),
        piece_b(:knight),
        piece_b(:rook)
      ],
      [
        piece_b(:pawn),
        piece_b(:pawn),
        piece_b(:pawn),
        piece_b(:pawn),
        piece_b(:pawn),
        piece_b(:pawn),
        piece_b(:pawn),
        piece_b(:pawn)
      ],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [
        piece_w(:pawn),
        piece_w(:pawn),
        piece_w(:pawn),
        piece_w(:pawn),
        piece_w(:pawn),
        piece_w(:pawn),
        piece_w(:pawn),
        piece_w(:pawn)
      ],
      [
        piece_w(:rook),
        piece_w(:knight),
        piece_w(:bishop),
        piece_w(:queen),
        piece_w(:king),
        piece_w(:bishop),
        piece_w(:knight),
        piece_w(:rook)
      ]
    ]
  end

  defp piece_w(type) do
    Piece.new(type, :white)
  end

  defp piece_b(type) do
    Piece.new(type, :black)
  end
end
