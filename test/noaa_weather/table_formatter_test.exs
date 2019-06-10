defmodule NoaaWeather.TableFormatterTest do
  use ExUnit.Case

  import NoaaWeather.TableFormatter, only: [to_columns: 1, max_width: 1, widths: 2]

  test "to_columns turns a list of tuples into columns" do
    assert to_columns([{"label1", "value1"}, {"label2", "value2"}]) == [
             ["label1", "label2"],
             ["value1", "value2"]
           ]
  end

  test "max_width returns the length of the largest string in a column" do
    assert max_width(["location", "relative_humidity"]) == 17
  end

  test "widths returns an array of the length of the longest string in each column, plus some padding value" do
    assert widths([["location", "relative_humidity"], ["Adak Island, Adak Airport, AK", "74"]], 0) ==
             [17, 29]
  end
end
