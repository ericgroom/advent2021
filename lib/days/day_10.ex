defmodule Advent2021.Days.Day10 do
  use Advent2021.Day

  def part_one(input) do
    input
    |> Enum.map(fn line -> validate_chunk(line) end)
    |> Enum.filter(&match?({:corrupted, _}, &1))
    |> Enum.map(fn {:corrupted, on} -> score(on) end)
    |> Enum.sum()
  end

  def part_two(input) do
    scores =
      input
      |> Enum.map(&validate_chunk/1)
      |> Enum.filter(&match?({:incomplete, _remaining}, &1))
      |> Enum.map(fn {:incomplete, remaining} -> Enum.map(remaining, &flip/1) end)
      |> Enum.map(&score_completion/1)

    middle_index = div(length(scores), 2)

    Enum.sort(scores)
    |> Enum.at(middle_index)
  end

  def validate_chunk(chunk, stack \\ [])
  def validate_chunk([], []), do: :valid
  def validate_chunk([], still_open), do: {:incomplete, still_open}

  def validate_chunk([next | rest], open_chunks) do
    if opener?(next) do
      validate_chunk(rest, [next | open_chunks])
    else
      [expected | remaining_open_chunks] = open_chunks

      if matching?(next, expected) do
        validate_chunk(rest, remaining_open_chunks)
      else
        {:corrupted, next}
      end
    end
  end

  def opener?("("), do: true
  def opener?("["), do: true
  def opener?("{"), do: true
  def opener?("<"), do: true
  def opener?(_closer), do: false

  def matching?("(", ")"), do: true
  def matching?("[", "]"), do: true
  def matching?("{", "}"), do: true
  def matching?("<", ">"), do: true
  def matching?(")", "("), do: true
  def matching?("]", "["), do: true
  def matching?("}", "{"), do: true
  def matching?(">", "<"), do: true
  def matching?(_, _), do: false

  def flip("("), do: ")"
  def flip("["), do: "]"
  def flip("{"), do: "}"
  def flip("<"), do: ">"

  def score(")"), do: 3
  def score("]"), do: 57
  def score("}"), do: 1197
  def score(">"), do: 25137

  def score_completion(remaining) do
    Enum.reduce(remaining, 0, fn char, score ->
      point =
        case char do
          ")" -> 1
          "]" -> 2
          "}" -> 3
          ">" -> 4
        end

      score * 5 + point
    end)
  end

  def parse(raw) do
    raw
    |> Parser.parse_list(&String.graphemes/1)
  end
end
