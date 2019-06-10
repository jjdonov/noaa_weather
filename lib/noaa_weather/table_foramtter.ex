defmodule NoaaWeather.TableFormatter do
  def format(labeled_fields) do
    to_columns(labeled_fields)
    |> widths()
    |> format_for()
    |> put_in_columns(labeled_fields)
  end

  def to_columns(labeled_fields) do
    Enum.unzip(labeled_fields)
    |> Tuple.to_list()
  end

  def widths(columns, padding \\ 5) do
    for column <- columns do
      max_width(column) + padding
    end
  end

  def max_width(column) do
    Enum.map(column, &String.length/1)
    |> Enum.max()
  end

  def format_for(widths) do
    Enum.map_join(widths, "|", fn width ->
      "~-#{width}s"
    end) <> "~n"
  end

  def put_in_columns(format_string, labeled_fields) do
    Enum.map(labeled_fields, &Tuple.to_list/1)
    |> Enum.map(fn row -> :io_lib.format(format_string, row) end)
  end
end
