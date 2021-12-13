defmodule Advent2021.Days.Day13Test do
  use ExUnit.Case, async: true
  alias Advent2021.Days.Day13

  @example_input """
                 6,10
                 0,14
                 9,10
                 0,3
                 10,4
                 4,11
                 6,0
                 6,12
                 4,1
                 0,13
                 10,12
                 3,4
                 3,0
                 8,4
                 1,10
                 2,14
                 8,10
                 9,0

                 fold along y=7
                 fold along x=5
                 """
                 |> Day13.parse()

  describe "part_one" do
    test "example input" do
      assert Day13.part_one(@example_input) == 17
    end

    test "real input" do
      assert Day13.part_one() == 695
    end
  end

  describe "part_two" do
    test "example input" do
      # assert Day13.part_two(@example_input) == 42
    end

    test "real input" do
      assert Day13.part_two() == """
             .##....##.####..##..#....#..#.###....##
             #..#....#....#.#..#.#....#..#.#..#....#
             #.......#...#..#....#....#..#.#..#....#
             #.##....#..#...#.##.#....#..#.###.....#
             #..#.#..#.#....#..#.#....#..#.#....#..#
             .###..##..####..###.####..##..#.....##.
             """
    end
  end
end
