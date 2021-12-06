defmodule Advent2021.Days.Day6Test do
  use ExUnit.Case, async: true
  alias Advent2021.Days.Day6

  @example_input [3, 4, 3, 1, 2]

  describe "part_one" do
    test "example input" do
      assert Day6.part_one(@example_input) == 5934
    end

    test "real input" do
      assert Day6.part_one() == 386_536
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day6.part_two(@example_input) == 26_984_457_539
    end

    test "real input" do
      assert Day6.part_two() == 1_732_821_262_171
    end
  end
end
