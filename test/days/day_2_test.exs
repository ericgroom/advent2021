defmodule Advent2021.Days.Day2Test do
  use ExUnit.Case, async: true
  alias Advent2021.Days.Day2

  @example_input [
    {:forward, 5},
    {:down, 5},
    {:forward, 8},
    {:up, 3},
    {:down, 8},
    {:forward, 2}
  ]

  describe "part_one" do
    test "example input" do
      assert Day2.part_one(@example_input) == 150
    end

    test "real input" do
      assert Day2.part_one() == 1727835
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day2.part_two(@example_input) == 900
    end

    test "real input" do
      assert Day2.part_two() == 1544000595
    end
  end
end
