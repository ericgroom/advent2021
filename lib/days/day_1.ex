defmodule Advent2021.Days.Day1 do
  use Advent2021.Day

  def part_one(input) do
    count_increases(input)
  end

  def part_two(input) do
    window(input)
    |> count_increases()
  end

  defp count_increases(list, previous \\ nil, count \\ 0)
  defp count_increases([], _previous, count), do: count
  defp count_increases([current | rest], nil, 0), do: count_increases(rest, current, 0)
  defp count_increases([current | rest], previous, count) do
    next = if current > previous, do: count + 1, else: count
    count_increases(rest, current, next)
  end

  defp window([]), do: []
  defp window(input) do
    [_ | rest] = input

    case input |> Enum.take(3) do
      [one, two, three] -> [one + two + three | window(rest)]
      _ -> []
    end
  end

  def parse(raw) do
    raw
    |> Parser.parse_list(&String.to_integer/1)
  end
end
