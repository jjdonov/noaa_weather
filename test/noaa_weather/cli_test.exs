defmodule NoaaWeather.CliTest do
  use ExUnit.Case
  doctest NoaaWeather.CLI

  import NoaaWeather.CLI, only: [parse_args: 1]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h"]) == :help
    assert parse_args(["--help"]) == :help
  end

  test "{station} returned when passed single arg" do
    assert parse_args(["PADK"]) == {"PADK"}
  end

  test ":help returned when multiple args passed" do
    assert parse_args(["PADK", "PAUT"]) == :help
  end
end
