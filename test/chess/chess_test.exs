defmodule Chess.ChessTest do
  use ExUnit.Case

  alias Chess.Dashboard

  test "dashboard test" do
    expected = [
      [
        %{type: :rook, color: :black},
        %{type: :knight, color: :black},
        %{type: :bishop, color: :black},
        %{type: :queen, color: :black},
        %{type: :king, color: :black},
        %{type: :bishop, color: :black},
        %{type: :knight, color: :black},
        %{type: :rook, color: :black}
      ],
      [
        %{type: :pawn, color: :black},
        %{type: :pawn, color: :black},
        %{type: :pawn, color: :black},
        %{type: :pawn, color: :black},
        %{type: :pawn, color: :black},
        %{type: :pawn, color: :black},
        %{type: :pawn, color: :black},
        %{type: :pawn, color: :black}
      ],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [
        %{type: :pawn, color: :white},
        %{type: :pawn, color: :white},
        %{type: :pawn, color: :white},
        %{type: :pawn, color: :white},
        %{type: :pawn, color: :white},
        %{type: :pawn, color: :white},
        %{type: :pawn, color: :white},
        %{type: :pawn, color: :white}
      ],
      [
        %{type: :rook, color: :white},
        %{type: :knight, color: :white},
        %{type: :bishop, color: :white},
        %{type: :queen, color: :white},
        %{type: :king, color: :white},
        %{type: :bishop, color: :white},
        %{type: :knight, color: :white},
        %{type: :rook, color: :white}
      ]
    ]

    assert expected == Dashboard.new()
  end
end
