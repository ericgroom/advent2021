defmodule Advent2021.Days.Day8 do
  use Advent2021.Day

  def part_one(input) do
    input
    |> Enum.flat_map(fn {_signal, output} -> output end)
    |> Enum.map(&potential_digits/1)
    |> Enum.count(fn
      [_single] -> true
      _multiple -> false
    end)
  end

  def part_two(input) do
    input
    |> Enum.map(fn {signal, output} ->
      key = decode_unique_signal(signal)

      output
      |> Enum.map(fn signal -> key[split(signal)] end)
      |> Enum.reduce(0, fn digit, acc -> acc * 10 + digit end)
    end)
    |> Enum.sum()
  end

  def decode_unique_signal(signal) do
    partially_decoded =
      signal
      |> Enum.map(fn signal -> {signal, potential_digits(signal)} end)
      |> Enum.into(%{})

    [one] = potential_signals_for_digit(partially_decoded, 1)

    # 0, 6, 9:
    # 0 containts both 1 segments
    # 9 contains both 1 segments
    # 6 containts 1 1 segment
    six =
      partially_decoded
      |> potential_signals_for_digit(6)
      |> Enum.find(fn signal ->
        wires = split(signal)
        MapSet.intersection(wires, split(one)) |> MapSet.size() == 1
      end)

    [bottom_right_segment] = MapSet.intersection(split(one), split(six)) |> Enum.into([])

    [top_right_segment] =
      MapSet.difference(split(one), MapSet.new([bottom_right_segment])) |> Enum.into([])

    # 9 is a superset of 4, zero is not
    [four] = potential_signals_for_digit(partially_decoded, 4)

    nine =
      partially_decoded
      |> potential_signals_for_digit(9)
      |> Enum.find(fn signal ->
        wires = split(signal)
        MapSet.subset?(split(four), wires)
      end)

    zero =
      partially_decoded
      |> potential_signals_for_digit(0)
      |> Enum.find(fn signal ->
        wires = split(signal)
        not MapSet.subset?(split(four), wires) and split(six) != wires
      end)

    # 2, 3, 5
    # 2 doesn't contain bottom right, others do
    two =
      partially_decoded
      |> potential_signals_for_digit(2)
      |> Enum.find(fn signal ->
        wires = split(signal)
        not MapSet.member?(wires, bottom_right_segment)
      end)

    # 5 doesn't contain top right
    five =
      partially_decoded
      |> potential_signals_for_digit(5)
      |> Enum.find(fn signal ->
        wires = split(signal)
        not MapSet.member?(wires, top_right_segment)
      end)

    # 3 contains both
    three =
      partially_decoded
      |> potential_signals_for_digit(3)
      |> Enum.find(fn signal ->
        wires = split(signal)
        MapSet.subset?(split(one), wires)
      end)

    [seven] = potential_signals_for_digit(partially_decoded, 7)
    [eight] = potential_signals_for_digit(partially_decoded, 8)

    %{
      split(zero) => 0,
      split(one) => 1,
      split(two) => 2,
      split(three) => 3,
      split(four) => 4,
      split(five) => 5,
      split(six) => 6,
      split(seven) => 7,
      split(eight) => 8,
      split(nine) => 9
    }
  end

  defp potential_signals_for_digit(partially_decoded, digit) do
    partially_decoded
    |> Enum.filter(fn
      {_signal, potentials} -> Enum.member?(potentials, digit)
    end)
    |> Enum.map(fn {signal, _} -> signal end)
  end

  defp split(digit_signal) do
    digit_signal |> String.graphemes() |> MapSet.new()
  end

  defp potential_digits(digit_signal) do
    case String.length(digit_signal) do
      2 -> [1]
      3 -> [7]
      4 -> [4]
      5 -> [5, 2, 3]
      6 -> [6, 9, 0]
      7 -> [8]
      _ -> raise "none"
    end
  end

  def parse(raw) do
    raw
    |> Parser.parse_list(fn line ->
      [signal_patterns, output] = String.split(line, " | ")
      signal_patterns = String.split(signal_patterns, " ")
      output = String.split(output, " ")
      {signal_patterns, output}
    end)
    |> Enum.into([])
  end
end
