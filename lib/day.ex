defmodule Advent2021.Day do
  @callback part_one(String.t()) :: any()
  @callback part_two(String.t()) :: any()

  defmacro __using__(_) do
    quote do
      @behaviour unquote(__MODULE__)
      @day_module __MODULE__
      @day_no Advent2021.Day.parse_day_from_module_name(@day_module)
      @inputs_dir unquote(__DIR__) |> Path.join("inputs")
      @input_file @inputs_dir |> Path.join("day_" <> Integer.to_string(@day_no) <> ".txt")
      @input File.read!(@input_file)

      Module.register_attribute(__MODULE__, :day, persist: true)
      Module.put_attribute(__MODULE__, :day, @day_no)

      alias Advent2021.Parser

      def part_one, do: call_if_exists(:part_one)
      def part_two, do: call_if_exists(:part_two)

      defp call_if_exists(func) do
        if Kernel.function_exported?(__MODULE__, func, 1) do
          apply(__MODULE__, func, [@input])
        else
          raise "#{__MODULE__} has not implemented #{func}/1"
        end
      end
    end
  end

  def parse_day_from_module_name(module_name) when is_atom(module_name) do
    day_name = module_name
      |> Atom.to_string()
      |> String.split(".")
      |> List.last()

    if not String.starts_with?(day_name, "Day") do
      raise "invalid format, expected 'Day' prefix"
    end

    day_no = String.replace_prefix(day_name, "Day", "")

    {day, _} = Integer.parse(day_no)

    day
  end
end
