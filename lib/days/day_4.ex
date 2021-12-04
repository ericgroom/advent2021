defmodule Advent2021.Days.Day4 do
  use Advent2021.Day
  alias __MODULE__.BingoBoard

  def part_one({numbers, boards}) do
    {winner, called_numbers, last_number} = find_winner(numbers, boards)
    BingoBoard.score(winner, called_numbers, last_number)
  end

  def part_two({numbers, boards}) do
    find_last_winner_score(numbers, boards)
  end

  def find_winner(numbers, boards) do
    Enum.reduce_while(numbers, [], fn n, acc ->
      called_numbers = MapSet.new([n | acc])
      case Enum.find(boards, &BingoBoard.winner?(&1, called_numbers)) do
        nil ->
          {:cont, [n | acc]}
        winner ->
          {:halt, {winner, called_numbers, n}}
      end
    end)
  end

  def find_last_winner_score(numbers, boards) do
    {_called, last_winner, _} = Enum.reduce(numbers, {[], [], boards}, fn n, {called, last_winner, boards} ->
      called_numbers = MapSet.new([n | called])
      case Enum.filter(boards, &BingoBoard.winner?(&1, called_numbers)) do
        [] ->
          {[n | called], last_winner, boards}
        [winner] ->
          score = BingoBoard.score(winner, called_numbers, n)
          {[n | called], score, boards |> List.delete(winner)}
        winners ->
          #score = BingoBoard.score(winner, called_numbers, n)
          {[n | called], :multiple, Enum.reject(boards, fn board -> Enum.member?(winners, board) end)}
      end
    end)

    last_winner
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
