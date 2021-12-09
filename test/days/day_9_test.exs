defmodule Advent2021.Days.Day9Test do
  use ExUnit.Case, async: true
  alias Advent2021.Days.Day9

  @example_input """
                 2199943210
                 3987894921
                 9856789892
                 8767896789
                 9899965678
                 """
                 |> Day9.parse()

  describe "part_one" do
    test "example input" do
      assert Day9.part_one(@example_input) == 15
    end

    test "real input" do
      assert Day9.part_one() == 423
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day9.part_two(@example_input) == 1134
    end

    test "real input" do
      assert Day9.part_two() == 1_198_704
    end
  end
end
