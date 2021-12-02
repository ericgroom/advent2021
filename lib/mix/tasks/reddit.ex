defmodule Mix.Tasks.Reddit do
  def run([day_no]) do
    day_no = String.to_integer(day_no)
    root = File.cwd!()
    day_source_path = Path.join([root, "lib", "days", "day_#{day_no}.ex"])
    day_source = day_source_path
      |> File.stream!()
      |> Stream.map(& "    " <> &1)
      |> Enum.join()

    prefix = """
    # Elixir

    preamble

    """

    suffix = """


    [Full Code](https://github.com/ericgroom/advent2021/blob/master/lib/days/day_#{day_no}.ex)
    """

    markdown = prefix <> day_source <> suffix
    Clipboard.copy!(markdown)
  end
end
