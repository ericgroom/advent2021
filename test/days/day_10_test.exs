defmodule Advent2021.Days.Day10Test do
  use ExUnit.Case, async: true
  alias Advent2021.Days.Day10

  @example_input """
                 [({(<(())[]>[[{[]{<()<>>
                 [(()[<>])]({[<{<<[]>>(
                 {([(<{}[<>[]}>{[]{[(<()>
                 (((({<>}<{<{<>}{[]{[]{}
                 [[<[([]))<([[{}[[()]]]
                 [{[{({}]{}}([{[{{{}}([]
                 {<[[]]>}<{[{[{[]{()[[[]
                 [<(<(<(<{}))><([]([]()
                 <{([([[(<>()){}]>(<<{{
                 <{([{{}}[<[[[<>{}]]]>[]]
                 """
                 |> Day10.parse()

  describe "part_one" do
    test "example input" do
      assert Day10.part_one(@example_input) == 26397
    end

    test "real input" do
      assert Day10.part_one() == 343_863
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day10.part_two(@example_input) == 288_957
    end

    test "real input" do
      assert Day10.part_two() == 2_924_734_236
    end
  end
end
