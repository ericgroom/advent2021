defmodule Advent2021.Days.Day4 do
  use Advent2021.Day
  alias __MODULE__.BingoBoard

  def part_one({numbers, boards}) do
    [winner] =
      score_stream(numbers, boards)
      |> Enum.find(&single_score?/1)

    winner
  end

  def part_two({numbers, boards}) do
    [loser] =
      score_stream(numbers, boards)
      |> Enum.into([])
      |> Enum.reverse()
      |> Enum.find(&single_score?/1)

    loser
  end

  defp score_stream(numbers, boards) do
    Stream.unfold({numbers, MapSet.new(), boards}, fn
      {[], _, _} ->
        nil

      {[n | to_call], called, boards} ->
        called = MapSet.put(called, n)
        winners = Enum.filter(boards, &BingoBoard.winner?(&1, called))
        scores = winners |> Enum.map(&BingoBoard.score(&1, called, n))
        {scores, {to_call, called, boards |> Enum.reject(&Enum.member?(winners, &1))}}
    end)
  end

  defp single_score?([]), do: false
  defp single_score?([_single]), do: true
  defp single_score?([_multiple | _scores]), do: false

  def parse(raw) do
    [numbers | boards] =
      raw
      |> String.split("\n\n", trim: true)

    numbers =
      numbers
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    boards =
      boards
      |> Enum.map(fn board ->
        String.split(board, "\n", trim: true)
        |> Enum.map(fn row ->
          row
          |> String.split(" ", trim: true)
          |> Enum.map(&String.to_integer/1)
        end)
        |> BingoBoard.new()
      end)

    {numbers, boards}
  end
end

defmodule Advent2021.Days.Day4.BingoBoard do
  defstruct [:rows]

  def new(rows) do
    %__MODULE__{
      rows: rows
    }
  end

  def winner?(board, numbers) do
    columns = board.rows |> List.zip() |> Enum.map(&Tuple.to_list/1)
    row_win = Enum.any?(board.rows, &winning_row?(&1, numbers))
    col_win = Enum.any?(columns, &winning_row?(&1, numbers))
    row_win or col_win
  end

  def score(board, called_numbers, last_number) do
    board_numbers = board.rows |> List.flatten()
    unmarked_sum = board_numbers |> Enum.reject(&MapSet.member?(called_numbers, &1)) |> Enum.sum()
    unmarked_sum * last_number
  end

  defp winning_row?(row, numbers) do
    Enum.all?(row, &MapSet.member?(numbers, &1))
  end
end
