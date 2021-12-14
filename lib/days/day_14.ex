defmodule Advent2021.Days.Day14 do
  use Advent2021.Day

  def part_one({polymer, pair_rules}) do
    Enum.reduce(1..10, pairs_from_polymer(polymer), fn _step, pairs ->
      grow(pairs, pair_rules)
    end)
    |> frequencies(polymer)
    |> Map.values()
    |> Enum.min_max()
    |> then(fn {min, max} -> max - min end)
  end

  def part_two({polymer, pair_rules}) do
    Enum.reduce(1..40, pairs_from_polymer(polymer), fn _step, pairs ->
      grow(pairs, pair_rules)
    end)
    |> frequencies(polymer)
    |> Map.values()
    |> Enum.min_max()
    |> then(fn {min, max} -> max - min end)
  end

  defp pairs_from_polymer(polymer) do
    polymer
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(&Enum.join/1)
    |> Enum.frequencies()
  end

  def grow(pairs, pair_rules) do
    Enum.reduce(pairs, %{}, fn {pair, current_amount}, acc ->
      [first, last] = String.graphemes(pair)
      medial = pair_rules[pair]

      Map.update(acc, first <> medial, current_amount, fn count -> count + current_amount end)
      |> Map.update(medial <> last, current_amount, fn count -> count + current_amount end)
    end)
  end

  defp frequencies(pairs, initial_polymer) do
    last = List.last(initial_polymer)

    Enum.reduce(pairs, %{last => 1}, fn {pair, count}, acc ->
      [first, _] = String.graphemes(pair)
      Map.update(acc, first, count, fn c -> c + count end)
    end)
  end

  def parse(raw) do
    [template, pairs] = String.split(raw, "\n\n", trim: true)
    template = String.graphemes(template)

    pairs =
      pairs
      |> Parser.parse_list(fn line ->
        [pair, middle] = String.split(line, " -> ")
        {pair, middle}
      end)
      |> Enum.into(%{})

    {template, pairs}
  end
end
