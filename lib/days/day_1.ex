defmodule Advent2021.Days.Day1 do
  use Advent2021.Day

  def part_one(input) do
    [first | rest] = input

    input = [{0, first} | rest]
    {increases, _} = input
    |> Enum.reduce(fn el, {acc, prev} ->
      if el > prev do
        {acc + 1, el}
      else
        {acc, el}
      end
    end)

    increases
  end

  def part_two(input) do
    input = window(input)
    [first | rest] = input

    input = [{0, first} | rest]
    {increases, _} = input
    |> Enum.reduce(fn el, {acc, prev} ->
      if el > prev do
        {acc + 1, el}
      else
        {acc, el}
      end
    end)

    increases
  end

  def window([]), do: []
  def window([next | rest]) do
    current = next
    case Enum.take(rest, 2) do
      [current2, current3] ->
        curr_window = current + current2 + current3
        [curr_window | window(rest)]
      _ ->
        []
    end

  end

  def parse(raw) do
    raw
    |> Parser.parse_list(&Parser.parse_int!/1)
  end
end
