defmodule Advent2021.Days.Day11 do
  use Advent2021.Day
  alias Advent2021.{Grid, Vec2D}

  def part_one(input) do
    input
    |> simulate_and_count_flashes(100)
  end

  def part_two(input) do
    find_first_simultaneous_flash(input)
  end

  defp find_first_simultaneous_flash(octopi, step \\ 1) do
    {octopi, flashed} = step(octopi)

    if MapSet.size(flashed) == 100 do
      step
    else
      find_first_simultaneous_flash(octopi, step + 1)
    end
  end

  defp simulate_and_count_flashes(octopi, step_count) do
    {flash_count, _} =
      Enum.reduce(1..step_count, {0, octopi}, fn _step, {flash_count, octopi} ->
        {new_ocotpi, flashed} = step(octopi)
        {flash_count + MapSet.size(flashed), new_ocotpi}
      end)

    flash_count
  end

  defp step(octopi) do
    octopi =
      Grid.coords(octopi)
      |> Enum.reduce(octopi, fn coord, new_grid ->
        increment(new_grid, coord)
      end)

    {octopi, flashed} = flash(octopi)
    octopi = reset(octopi, flashed)
    {octopi, flashed}
  end

  defp flash(octopi, flashed \\ MapSet.new()) do
    {new_octopi, new_flashed} =
      Grid.coords(octopi)
      |> Enum.reduce({octopi, flashed}, fn coord, {octopi, flashed} ->
        if Grid.at(octopi, coord) > 9 and coord not in flashed do
          neighbors = Vec2D.diagonal_unit_vectors() |> Enum.map(&Vec2D.add(&1, coord))
          grid = Enum.reduce(neighbors, octopi, fn coord, grid -> increment(grid, coord) end)
          {grid, MapSet.put(flashed, coord)}
        else
          {octopi, flashed}
        end
      end)

    if new_flashed != flashed do
      flash(new_octopi, new_flashed)
    else
      {new_octopi, new_flashed}
    end
  end

  defp reset(octopi, flashed) do
    Enum.reduce(flashed, octopi, fn coord, octopi -> Grid.put(octopi, coord, 0) end)
  end

  defp increment(grid, at) do
    case Grid.at(grid, at) do
      :invalid_coord -> grid
      value -> Grid.put(grid, at, value + 1)
    end
  end

  def parse(raw) do
    raw
    |> Parser.parse_list(fn line -> String.graphemes(line) |> Enum.map(&String.to_integer/1) end)
    |> Grid.new()
  end
end
