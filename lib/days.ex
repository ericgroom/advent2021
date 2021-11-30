defmodule Advent2021.Days do
  def all_days do
    {:ok, modules} = :application.get_key(:advent2021, :modules)

    modules
    |> Enum.filter(&day_implementation?/1)
    |> Enum.map(&with_day/1)
  end

  defp day_implementation?(module) do
    behaviors = module.module_info(:attributes)[:behaviour]

    case behaviors do
      nil -> false
      list -> Enum.member?(list, Advent2021.Day)
    end
  end

  defp with_day(module) do
    [day] = module.module_info(:attributes)[:day]
    {day, module}
  end
end
