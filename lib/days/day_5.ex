defmodule Advent2021.Days.Day5 do
  use Advent2021.Day

  def part_one(input) do
    input
    |> Enum.filter(&straight?/1)
    |> calculate_vent_locations()
    |> Enum.count(fn {_k, count} -> count >= 2 end)
  end

  def part_two(input) do
    input
    |> calculate_vent_locations()
    |> Enum.count(fn {_k, count} -> count >= 2 end)
  end

  def calculate_vent_locations(lines) do
    lines
    |> Enum.flat_map(&points_in_line/1)
    |> Enum.reduce(%{}, fn point, map ->
      Map.update(map, point, 1, &(&1 + 1))
    end)
  end

  defp straight?({{x1, y1}, {x2, y2}}), do: x1 == x2 or y1 == y2

  def points_in_line({{x1, y1}, {x2, y2}}) do
    Enum.zip(stride(x1, x2), stride(y1, y2))
  end

  defp stride(a, b) when a == b, do: Stream.repeatedly(fn -> a end)
  defp stride(a, b), do: a..b

  def parse(raw) do
    raw
    |> Parser.parse_list(fn line ->
      [start, finish] = String.split(line, " -> ", trim: true)
      {parse_coord(start), parse_coord(finish)}
    end)
    |> Enum.into([])
  end

  defp parse_coord(coord) do
    [x, y] = String.split(coord, ",")
    {String.to_integer(x), String.to_integer(y)}
  end
end
