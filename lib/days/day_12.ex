defmodule Advent2021.Days.Day12 do
  use Advent2021.Day

  def part_one(input) do
    input
    |> find_paths("start", fn neighbors, path_so_far ->
      cave_visits = Enum.frequencies(path_so_far)

      {lower_caves, upper_caves} = Enum.split_with(neighbors, &lower_case_cave?/1)
      lower_caves = lower_caves |> Enum.reject(&already_visited?(&1, cave_visits))
      lower_caves ++ upper_caves
    end)
  end

  def part_two(input) do
    input
    |> find_paths("start", fn neighbors, path_so_far ->
      cave_visits = Enum.frequencies(path_so_far)
      used_double_visit = small_cave_visited_twice(cave_visits)

      {lower_caves, upper_caves} = Enum.split_with(neighbors, &lower_case_cave?/1)

      lower_caves =
        lower_caves
        |> Enum.filter(fn cave ->
          not used_double_visit or not already_visited?(cave, cave_visits)
        end)

      lower_caves ++ upper_caves
    end)
  end

  def find_paths(map, from, allow_visit, path_so_far \\ [])
  def find_paths(_map, "end", _, _path_so_far), do: 1

  def find_paths(map, from, filter_neighbors, path_so_far) do
    able_to_visit =
      map[from]
      |> Enum.reject(&(&1 == "start"))
      |> filter_neighbors.([from | path_so_far])

    for neighbor <- able_to_visit do
      find_paths(map, neighbor, filter_neighbors, [from | path_so_far])
    end
    |> List.flatten()
    |> Enum.sum()
  end

  defp small_cave_visited_twice(frequencies) do
    frequencies
    |> Enum.any?(fn {cave, visits} -> lower_case_cave?(cave) and visits > 1 end)
  end

  defp already_visited?(cave, frequencies) do
    Map.has_key?(frequencies, cave)
  end

  defp lower_case_cave?(cave) do
    first_letter = String.graphemes(cave) |> List.first()
    first_letter != String.upcase(first_letter)
  end

  def parse(raw) do
    raw
    |> Parser.parse_list(fn line ->
      [start, finish] = String.split(line, "-")
      {start, finish}
    end)
    |> Enum.reduce(Map.new(), fn {start, finish}, map ->
      map
      |> Map.update(start, MapSet.new([finish]), &MapSet.put(&1, finish))
      |> Map.update(finish, MapSet.new([start]), &MapSet.put(&1, start))
    end)
  end
end
