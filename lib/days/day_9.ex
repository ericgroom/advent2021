defmodule Advent2021.Days.Day9 do
  use Advent2021.Day
  alias Advent2021.Grid

  def part_one({grid, width, height}) do
    grid
    |> low_points(width, height)
    |> Enum.map(fn coord -> Grid.at(grid, coord) + 1 end)
    |> Enum.sum()
  end

  def part_two({grid, width, height}) do
    grid
    |> low_points(width, height)
    |> Enum.map(fn low_point ->
      basin_size({grid, width, height}, [low_point])
    end)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.reduce(&*/2)
  end

  defp low_points(grid, width, height) do
    grid
    |> Grid.coords()
    |> Enum.map(fn coord ->
      neighbors = neighbors(coord) |> Enum.filter(&valid_coord?(&1, width, height))
      {coord, neighbors}
    end)
    |> Enum.filter(fn {coord, neighbors} ->
      value = Grid.at(grid, coord)
      values = Enum.map(neighbors, fn neighbor -> Grid.at(grid, neighbor) end)
      Enum.all?(values, fn v -> v > value end)
    end)
    |> Enum.map(fn {coord, _} -> coord end)
  end

  defp basin_size(info, queue, visited \\ MapSet.new(), size \\ 0)
  defp basin_size(_, [], _, size), do: size

  defp basin_size({grid, width, height} = info, [next | rest], visited, size) do
    cond do
      MapSet.member?(visited, next) or Grid.at(grid, next) == 9 ->
        basin_size(info, rest, visited |> MapSet.put(next), size)

      true ->
        neighbors = neighbors(next) |> Enum.filter(&valid_coord?(&1, width, height))
        basin_size(info, rest ++ neighbors, visited |> MapSet.put(next), size + 1)
    end
  end

  def neighbors({x, y}) do
    [
      {x - 1, y},
      {x, y - 1},
      {x + 1, y},
      {x, y + 1}
    ]
  end

  def valid_coord?({x, y}, width, height) do
    x >= 0 and y >= 0 and x < width and y < height
  end

  def parse(raw) do
    lines =
      raw
      |> Parser.parse_list()

    height = Enum.count(lines)

    lists =
      lines
      |> Enum.map(fn line -> line |> String.graphemes() |> Enum.map(&String.to_integer/1) end)

    width = List.first(lists) |> Enum.count()

    grid =
      lists
      |> Grid.new()

    {grid, width, height}
  end
end
