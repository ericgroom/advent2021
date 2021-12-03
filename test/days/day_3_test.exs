defmodule Advent2021.Days.Day3Test do
  use ExUnit.Case, async: true
  alias Advent2021.Days.Day3

  @example_input [
    "00100",
    "11110",
    "10110",
    "10111",
    "10101",
    "01111",
    "00111",
    "11100",
    "10000",
    "11001",
    "00010",
    "01010"
  ]

  describe "part_one" do
    test "example input" do
      assert Day3.part_one(@example_input) == 198
    end

    test "real input" do
      assert Day3.part_one() == 2498354
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day3.part_two(@example_input) == 230
    end

    test "real input" do
      assert Day3.part_two() == 3277956
    end
  end
end
