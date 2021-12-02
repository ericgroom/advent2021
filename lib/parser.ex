defmodule Advent2021.Parser do
  def parse_list(raw, f) do
    raw
    |> Stream.map(&String.trim/1)
    |> Stream.reject(& &1 == "")
    |> Stream.map(f)
  end
end
