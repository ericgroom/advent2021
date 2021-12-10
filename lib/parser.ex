defmodule Advent2021.Parser do
  def parse_list(raw, f \\ & &1) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(f)
  end
end
