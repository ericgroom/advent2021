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
      |> Enum.map(fn signal -> digit_in_key(key, signal) end)
      |> Enum.reduce(0, fn digit, acc -> acc * 10 + digit end)
    end)
    |> Enum.sum()
  end

  defp digit_in_key(key, signal) do
    {_signal, digit} = find_one(key, fn {s, _digit} -> split(s) == split(signal) end)
    digit
  end

  def decode_unique_signal(signal) do
    partially_decoded =
      signal
      |> Enum.map(fn signal -> {signal, potential_digits(signal)} end)
      |> Enum.into(%{})

    one = segments_for_digit(partially_decoded, 1)

    # 0, 6, 9:
    # 0 containts both 1 segments
    # 9 contains both 1 segments
    # 6 containts 1 1 segment
    six =
      partially_decoded
      |> potential_signals_for_digit(6)
      |> find_one(fn signal ->
        digits = split(signal)
        MapSet.intersection(digits, one) |> MapSet.size() == 1
      end)

    [bottom_right_segment] = MapSet.intersection(one, split(six)) |> Enum.into([])

    [top_right_segment] =
      MapSet.difference(one, MapSet.new([bottom_right_segment])) |> Enum.into([])

    # 9 is a superset of 4, zero is not
    four = segments_for_digit(partially_decoded, 4)

    nine =
      partially_decoded
      |> potential_signals_for_digit(9)
      |> find_one(fn signal ->
        digits = split(signal)
        MapSet.subset?(four, digits)
      end)

    zero =
      partially_decoded
      |> potential_signals_for_digit(0)
      |> find_one(fn signal ->
        digits = split(signal)
        not MapSet.subset?(four, digits) and split(six) != digits
      end)

    # 2, 3, 5
    # 2 doesn't contain bottom right, others do
    two =
      partially_decoded
      |> potential_signals_for_digit(2)
      |> find_one(fn signal ->
        digits = split(signal)
        not MapSet.member?(digits, bottom_right_segment)
      end)

    # 5 doesn't contain top right
    five =
      partially_decoded
      |> potential_signals_for_digit(5)
      |> find_one(fn signal ->
        digits = split(signal)
        not MapSet.member?(digits, top_right_segment)
      end)

    # 3 contains both
    three =
      partially_decoded
      |> potential_signals_for_digit(3)
      |> find_one(fn signal ->
        digits = split(signal)
        MapSet.subset?(one, digits)
      end)

    [one] = potential_signals_for_digit(partially_decoded, 1)
    [four] = potential_signals_for_digit(partially_decoded, 4)
    [seven] = potential_signals_for_digit(partially_decoded, 7)
    [eight] = potential_signals_for_digit(partially_decoded, 8)

    %{
      zero => 0,
      one => 1,
      two => 2,
      three => 3,
      four => 4,
      five => 5,
      six => 6,
      seven => 7,
      eight => 8,
      nine => 9
    }
  end

  defp find_one(enum, f) do
    result = Enum.filter(enum, f)

    if length(result) == 1 do
      [elem] = result
      elem
    else
      raise "attempted to find one result but found #{length(result)}: #{inspect(result)}"
    end
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

  defp segments_for_digit(partially_decoded, digit) do
    partially_decoded
    |> Enum.find_value(fn
      {signal, [^digit]} -> signal
      _ -> nil
    end)
    |> String.graphemes()
    |> MapSet.new()
  end

  defp potential_digits(digit_signal) do
    case String.length(digit_signal) do
      1 -> raise "none"
      2 -> [1]
      3 -> [7]
      4 -> [4]
      5 -> [5, 2, 3]
      6 -> [6, 9, 0]
      7 -> [8]
      _ -> :unknown
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
