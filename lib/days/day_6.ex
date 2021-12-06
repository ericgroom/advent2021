defmodule Advent2021.Days.Day6 do
  use Advent2021.Day

  def part_one(input) do
    fish_count = count_fish(input)

    Enum.reduce(1..80, fish_count, fn _gen, fish_counts ->
      next_generation(fish_counts)
    end)
    |> total_fish()
  end

  def part_two(input) do
    fish_count = count_fish(input)

    Enum.reduce(1..256, fish_count, fn _gen, fish_counts ->
      next_generation(fish_counts)
    end)
    |> total_fish()
  end

  defp next_generation(fish_counts) do
    new_generation = %{
      8 => fish_counts[0],
      7 => fish_counts[8],
      6 => fish_counts[0] + fish_counts[7],
      5 => fish_counts[6],
      4 => fish_counts[5],
      3 => fish_counts[4],
      2 => fish_counts[3],
      1 => fish_counts[2],
      0 => fish_counts[1]
    }

    new_generation
  end

  defp total_fish(fish_counts) do
    Enum.reduce(fish_counts, 0, fn {_gen, count}, acc -> acc + count end)
  end

  defp count_fish(fish) do
    fish
    |> Enum.frequencies()
    |> then(fn map ->
      map
      |> Map.put_new(0, 0)
      |> Map.put_new(1, 0)
      |> Map.put_new(2, 0)
      |> Map.put_new(3, 0)
      |> Map.put_new(4, 0)
      |> Map.put_new(5, 0)
      |> Map.put_new(6, 0)
      |> Map.put_new(7, 0)
      |> Map.put_new(8, 0)
    end)
  end

  def parse(raw) do
    raw
    |> String.split(",", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
  end
end
