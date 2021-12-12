defmodule Advent2021.Days.Day12Test do
  use ExUnit.Case, async: true
  alias Advent2021.Days.Day12

  @example_input """
                 start-A
                 start-b
                 A-c
                 A-b
                 b-d
                 A-end
                 b-end
                 """
                 |> Day12.parse()

  @medium_example """
                  dc-end
                  HN-start
                  start-kj
                  dc-start
                  dc-HN
                  LN-dc
                  HN-end
                  kj-sa
                  kj-HN
                  kj-dc
                  """
                  |> Day12.parse()

  @large_example """
                 fs-end
                 he-DX
                 fs-he
                 start-DX
                 pj-DX
                 end-zg
                 zg-sl
                 zg-pj
                 pj-he
                 RW-he
                 fs-DX
                 pj-RW
                 zg-RW
                 start-pj
                 he-WI
                 zg-he
                 pj-fs
                 start-RW
                 """
                 |> Day12.parse()

  describe "part_one" do
    test "example input" do
      assert Day12.part_one(@example_input) == 10
    end

    test "medium input" do
      assert Day12.part_one(@medium_example) == 19
    end

    test "large input" do
      assert Day12.part_one(@large_example) == 226
    end

    test "real input" do
      assert Day12.part_one() == 3463
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day12.part_two(@example_input) == 36
    end

    test "medium input" do
      assert Day12.part_two(@medium_example) == 103
    end

    test "large input" do
      assert Day12.part_two(@large_example) == 3509
    end

    test "real input" do
      assert Day12.part_two() == 91533
    end
  end
end
