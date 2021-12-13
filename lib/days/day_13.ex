defmodule Advent2021.Days.Day13 do
  use Advent2021.Day
  alias Advent2021.Grid

  def part_one(input) do
    {grid, folds} = input
    [first_fold | _rest] = folds

    fold(grid, first_fold)
    |> Grid.coords()
    |> Enum.count()
  end

  def part_two(input) do
    {grid, folds} = input

    Enum.reduce(folds, grid, fn fold, grid ->
      fold(grid, fold)
    end)
    |> inspect_grid()
  end

  def fold(grid, {axis, fold_at}) do
    Grid.coords(grid)
    |> Enum.reduce(Grid.new(), fn coord, new_grid ->
      value = Grid.at(grid, coord)
      location = value_for_axis(coord, axis)

      cond do
        location == fold_at ->
          raise("breaks rules")

        location < fold_at ->
          Grid.put(new_grid, coord, value)

        location > fold_at ->
          distance_to_line = location - fold_at
          new_location = location - 2 * distance_to_line
          coord = replace_single_axis(coord, axis, new_location)
          Grid.put(new_grid, coord, value)
      end
    end)
  end

  defp value_for_axis({x, _}, :x), do: x
  defp value_for_axis({_, y}, :y), do: y

  defp replace_single_axis({_, y}, :x, new_x), do: {new_x, y}
  defp replace_single_axis({x, _}, :y, new_y), do: {x, new_y}

  def inspect_grid(grid) do
    coords = Grid.coords(grid)
    width = Enum.map(coords, fn {x, _} -> x end) |> Enum.max()
    height = Enum.map(coords, fn {_, y} -> y end) |> Enum.max()

    for y <- 0..height do
      Enum.map(0..width, fn x ->
        case Grid.at(grid, {x, y}) do
          :invalid_coord -> "."
          :dot -> "#"
        end
      end)
      |> Enum.join()
      |> then(fn line -> line <> "\n" end)
    end
    |> Enum.join()
  end

  def parse(raw) do
    [dots, folds] = raw |> String.split("\n\n", trim: true)

    dots =
      dots
      |> Parser.parse_list(fn line ->
        [x, y] = String.split(line, ",")
        {x |> String.to_integer(), y |> String.to_integer()}
      end)
      |> Enum.map(fn coord -> {coord, :dot} end)
      |> Enum.into(%{})
      |> Grid.new()

    folds =
      folds
      |> Parser.parse_list(fn line ->
        instruction = String.replace_prefix(line, "fold along ", "")
        [axis, value] = String.split(instruction, "=")
        {axis |> String.to_atom(), value |> String.to_integer()}
      end)

    {dots, folds}
  end
end
