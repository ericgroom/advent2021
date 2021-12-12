defmodule Advent2021.Days.Day12 do
  use Advent2021.Day

  def part_one(input) do
    input
    |> find_paths("start", 1)
  end

  def part_two(input) do
    input
    |> find_paths("start", 2)
  end

  def find_paths(map, from, max_lower_cave_visits, path_so_far \\ [])

  def find_paths(_map, "end", _, path_so_far) do
    # IO.puts(["end" | path_so_far] |> Enum.reverse() |> Enum.join(","))
    1
  end

  def find_paths(map, from, max_lower_cave_visits, path_so_far) do
    cave_visits = [from | path_so_far] |> Enum.frequencies()

    small_cave_visited_twice =
      cave_visits
      |> Enum.any?(fn {cave, visits} -> lower_case_cave?(cave) and visits > 1 end)

    # cave_visits
    # |> Enum.filter(fn {cave, visits} -> lower_case_cave?(cave) and visits > 1 end)
    # |> Enum.count()
    # |> then(fn count ->
    #   if count > 1 do
    #     raise "wtf, #{inspect(path_so_far)}"
    #   end
    # end)

    able_to_visit =
      map[from]
      |> Enum.reject(&(&1 == "start"))
      |> Enum.filter(fn cave ->
        if lower_case_cave?(cave) do
          visit_count = cave_visits[cave] || 0

          if small_cave_visited_twice or max_lower_cave_visits == 1 do
            visit_count == 0
          else
            visit_count < 2
          end
        else
          true
        end
      end)

    for neighbor <- able_to_visit do
      find_paths(map, neighbor, max_lower_cave_visits, [from | path_so_far])
    end
    |> List.flatten()
    |> Enum.sum()
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
