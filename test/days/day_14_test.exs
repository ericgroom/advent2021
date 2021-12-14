defmodule Advent2021.Days.Day14Test do
  use ExUnit.Case, async: true
  alias Advent2021.Days.Day14

  @example_input """
                 NNCB

                 CH -> B
                 HH -> N
                 CB -> H
                 NH -> C
                 HB -> C
                 HC -> B
                 HN -> C
                 NN -> C
                 BH -> H
                 NC -> B
                 NB -> B
                 BN -> B
                 BB -> N
                 BC -> B
                 CC -> N
                 CN -> C
                 """
                 |> Day14.parse()

  describe "part_one" do
    test "example input" do
      assert Day14.part_one(@example_input) == 1588
    end

    test "real input" do
      assert Day14.part_one() == 4517
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day14.part_two(@example_input) == 2_188_189_693_529
    end

    test "real input" do
      assert Day14.part_two() == 4_704_817_645_083
    end
  end
end
