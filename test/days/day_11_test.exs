defmodule Advent2021.Days.Day11Test do
  use ExUnit.Case, async: true
  alias Advent2021.Days.Day11

  @example_input """
                 5483143223
                 2745854711
                 5264556173
                 6141336146
                 6357385478
                 4167524645
                 2176841721
                 6882881134
                 4846848554
                 5283751526
                 """
                 |> Day11.parse()

  describe "part_one" do
    test "example input" do
      assert Day11.part_one(@example_input) == 1656
    end

    test "real input" do
      assert Day11.part_one() == 1625
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day11.part_two(@example_input) == 195
    end

    test "real input" do
      assert Day11.part_two() == 244
    end
  end
end
