defmodule Advent2021.Days.Day1 do
  use Advent2021.Day

  def part_one(input) do
    count_increases(input)
  end

  def part_two(input) do
    window(input)
    |> count_increases()
  end

  defp count_increases(list) do
    list
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [a, b] -> b > a end)
  end

  defp window(list) do
    list
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(&Enum.sum/1)
  end

  def parse(raw) do
    raw
    |> Parser.parse_list(&String.to_integer/1)
  end
end
