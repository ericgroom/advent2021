defmodule Advent2021.Days.Day3 do
  use Advent2021.Day

  def part_one(input) do
    {gamma, epsilon} = gamma_epsilon_rates(input)
    gamma * epsilon
  end

  def part_two(input) do
    {o2, co2} = oxygen_generator_CO2_scrubber_ratings(input)
    o2 * co2
  end

  def oxygen_generator_CO2_scrubber_ratings(diagnostic_report) do
    digits = diagnostic_report
      |> Enum.map(&String.graphemes/1)

    oxygen_generator = filter_grid(digits, &most_common(&1, "1"))
      |> to_binary()

    cO2_scrubber = filter_grid(digits, fn column -> least_common(column, "0") end)
      |> to_binary()

    {oxygen_generator, cO2_scrubber}
  end

  defp filter_grid(grid, keep_predicate, search_column \\ 0) do
    remaining_nums = Enum.count(grid)
    cond do
      remaining_nums <= 0 ->
        raise "invalid state"
      remaining_nums == 1 ->
        List.first(grid)
      true ->
        column = column(grid, search_column)
        keep_digit = keep_predicate.(column)
        new_grid = Enum.filter(grid, fn list ->
          Enum.at(list, search_column) == keep_digit
        end)
        filter_grid(new_grid, keep_predicate, search_column + 1)
    end

  end

  def gamma_epsilon_rates(diagnostic_report) do
    digits = diagnostic_report
      |> Enum.map(&String.graphemes/1)

    digit_len = Enum.count(List.first(digits))
    gamma_rate = for i <- 0..(digit_len-1) do
      most_common(column(digits, i))
    end
    epsilon_rate = invert(gamma_rate)
    {gamma_rate |> to_binary(), epsilon_rate |> to_binary()}
  end

  defp to_binary(digits) do
    Enum.join(digits)
    |> String.to_integer(2)
  end

  defp invert("0"), do: "1"
  defp invert("1"), do: "0"
  defp invert(digits) when is_list(digits) do
    Enum.map(digits, &invert/1)
  end

  defp column(grid, index) do
    Enum.map(grid, fn row -> Enum.at(row, index) end)
      |> Enum.reject(&is_nil/1)
  end

  defp most_common(list, winner \\ "1") do
    Enum.frequencies(list)
      |> then(fn %{"1" => ones, "0" => zeros} ->
        if ones == zeros, do: winner, else:
          if ones > zeros, do: "1", else: "0"
      end)
  end
  defp least_common(list, winner) do
    Enum.frequencies(list)
      |> then(fn %{"1" => ones, "0" => zeros} ->
        if ones == zeros, do: winner, else:
          if ones < zeros, do: "1", else: "0"
      end)
  end

  def parse(raw) do
    raw
      |> Parser.parse_list(& &1)
  end
end
