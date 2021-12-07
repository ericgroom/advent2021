defmodule Advent2021.Days.Day7Test do
  use ExUnit.Case, async: true
  alias Advent2021.Days.Day7

  @example_input [16, 1, 2, 0, 4, 2, 7, 1, 2, 14]

  describe "part_one" do
    test "example input" do
      assert Day7.part_one(@example_input) == 37
    end

    test "real input" do
      assert Day7.part_one() == 345_197
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day7.part_two(@example_input) == 168
    end

    test "real input" do
      assert Day7.part_two() == 96_361_606
    end
  end
end
