defmodule Advent2021.Days.Day7 do
  use Advent2021.Day

  def part_one(input) do
    median = median(input)

    input
    |> Enum.map(&fuel_cost(&1, median))
    |> Enum.sum()
  end

  def part_two(input) do
    {low, high} = average(input)

    low_cost =
      input
      |> Enum.map(&fuel_cost_2(&1, low))
      |> Enum.sum()

    high_cost =
      input
      |> Enum.map(&fuel_cost_2(&1, high))
      |> Enum.sum()

    min(low_cost, high_cost)
  end

  def fuel_cost(from, to) do
    abs(from - to)
  end

  def fuel_cost_2(from, to) do
    for add_cost <- 0..abs(from - to) do
      add_cost
    end
    |> Enum.sum()
  end

  def median(nums) do
    sorted = Enum.sort(nums)
    len = length(nums)
    median_idx = round(len / 2)
    Enum.at(sorted, median_idx)
  end

  def average(nums) do
    fractional = Enum.sum(nums) / length(nums)
    {floor(fractional), ceil(fractional)}
  end

  def parse(raw) do
    raw
    |> String.split(",", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
  end
end
