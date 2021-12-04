defmodule Advent2021.Days.Day1Test do
  use ExUnit.Case
  alias Advent2021.Days.Day1

  @example [
    199,
    200,
    208,
    210,
    200,
    207,
    240,
    269,
    260,
    263
  ]

  describe "part_one" do
    test "example input" do
      assert Day1.part_one(@example) == 7
    end

    test "real input" do
      assert Day1.part_one() == 1390
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day1.part_two(@example) == 5
    end

    test "real input" do
      assert Day1.part_two() == 1457
    end
  end
end
