defmodule Advent2021.Days.Day5Test do
  use ExUnit.Case, async: true
  alias Advent2021.Days.Day5

  @example_input """
                 0,9 -> 5,9
                 8,0 -> 0,8
                 9,4 -> 3,4
                 2,2 -> 2,1
                 7,0 -> 7,4
                 6,4 -> 2,0
                 0,9 -> 2,9
                 3,4 -> 1,4
                 0,0 -> 8,8
                 5,5 -> 8,2
                 """
                 |> Day5.parse()

  describe "part_one" do
    test "example input" do
      assert Day5.part_one(@example_input) == 5
    end

    test "real input" do
      assert Day5.part_one() == 4421
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day5.part_two(@example_input) == 12
    end

    test "real input" do
      assert Day5.part_two() == 18674
    end
  end
end
