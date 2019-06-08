defmodule NoaaWeather.CLI do
  def main do
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
end
