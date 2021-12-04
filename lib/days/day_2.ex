defmodule Advent2021.Days.Day2 do
  use Advent2021.Day

  def part_one(input) do
    {depth, position} = follow_course(input)
    depth * position
  end

  def part_two(input) do
    {depth, position, _aim} = follow_correct_course(input)
    depth * position
  end

  def follow_course(course) do
    Enum.reduce(course, {0, 0}, fn {direction, amount}, {depth, position} ->
      case direction do
        :forward ->
          {depth, position + amount}

        :down ->
          {depth + amount, position}

        :up ->
          {depth - amount, position}
      end
    end)
  end

  def follow_correct_course(course) do
    Enum.reduce(course, {0, 0, 0}, fn {direction, amount}, {depth, position, aim} ->
      case direction do
        :down ->
          {depth, position, aim + amount}

        :up ->
          {depth, position, aim - amount}

        :forward ->
          {depth + amount * aim, position + amount, aim}
      end
    end)
  end

  def parse(raw) do
    raw
    |> Parser.parse_list(fn movement ->
      [direction, amount] = String.split(movement)
      {String.to_atom(direction), String.to_integer(amount)}
    end)
  end
end
