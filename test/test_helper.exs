defmodule Chess.TestHelper do
  def null_dashboard() do
    for _ <- 0..7 do
      Enum.map(0..7, fn _ -> nil end)
    end
  end

  def put_in_board(board, piece, {pos_x, pos_y}) do
    new_col =
      board
      |> Enum.at(pos_x)
      |> List.replace_at(pos_y, piece)

    List.replace_at(board, pos_x, new_col)
  end
end

ExUnit.start()
