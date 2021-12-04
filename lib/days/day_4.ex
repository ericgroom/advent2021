defmodule Advent2021.Days.Day4 do
  use Advent2021.Day
  alias __MODULE__.BingoBoard

  def part_one({numbers, boards}) do
    find_first_winner_score(numbers, boards)
  end

  def part_two({numbers, boards}) do
    find_last_winner_score(numbers, boards)
  end

  def find_first_winner_score(numbers, boards) do
    {[winner], _to_call, called, last} = find_next_winners(numbers, MapSet.new(), boards)
    BingoBoard.score(winner, called, last)
  end

  defp find_next_winners([], _, _), do: :exhausted
  defp find_next_winners([n | to_call], called, boards) do
    called = MapSet.put(called, n)
    winners = Enum.filter(boards, &BingoBoard.winner?(&1, called))
    case winners do
      [] ->
        find_next_winners(to_call, called, boards)
      winners ->
        {winners, to_call, called, n}
    end
  end
  def find_last_winner_score(numbers, boards, called \\ MapSet.new(), last_solo_score \\ nil)
  def find_last_winner_score([], _boards, _called, last_solo_score), do: last_solo_score
  def find_last_winner_score(numbers, boards, called, last_solo_score) do
    case find_next_winners(numbers, called, boards) do
      :exhausted ->
        last_solo_score
      {[winner], to_call, called, last} ->
        score = BingoBoard.score(winner, called, last)
        find_last_winner_score(to_call, boards |> List.delete(winner), called, score)
      {winners, to_call, called, _last} ->
        find_last_winner_score(to_call, boards |> Enum.reject(fn board -> Enum.member?(winners, board) end), called, nil)
    end
  end
  def parse(raw) do
    [numbers | boards] = raw
      |> String.split("\n\n", trim: true)

    numbers = numbers
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    boards = boards
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
