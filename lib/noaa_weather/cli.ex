defmodule NoaaWeather.CLI do
  alias NoaaWeather.Service
  alias NoaaWeather.TableFormatter, as: Formatter

  def main(argv) do
    argv
    |> parse_args()
    |> process()
  end

  def parse_args(argv) do
    OptionParser.parse(argv,
      switches: [help: :boolean],
      aliases: [h: :help]
    )
    |> args_to_internal_representation()
  end

  defp args_to_internal_representation({[help: true], _, _}), do: :help
  defp args_to_internal_representation({_, [station], _}), do: {station}
  defp args_to_internal_representation(_), do: :help

  def process(:help) do
    IO.puts("""
    usage: noaa_weather <station_id>
    """)
  end

  def process({station}) do
    Service.fetch(station)
    |> print_result()
  end

  def print_result({:error, _}) do
    IO.puts("Something went wrong")
  end

  def print_result({:ok, result}) when is_list(result) do
    Formatter.format(result)
    |> IO.puts()
  end
end
