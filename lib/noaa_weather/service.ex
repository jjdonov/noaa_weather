defmodule NoaaWeather.Service do
  import Record, only: [defrecord: 2, extract: 2]
  defrecord :xmlText, extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")

  @service_url Application.get_env(:noaa_weather, :service_url)

  @children ["location", "observation_time", "temp_f", "relative_humidity", "weather"]
  @base_path "/current_observation/"
  @child_paths Enum.map(@children, fn child ->
                 path = Path.join([@base_path, child, "text()"]) |> String.to_charlist()
                 {child, path}
               end)

  def fetch(station) do
    station_url(station)
    |> HTTPoison.get()
    |> handle_response()
  end

  def station_url(station) do
    URI.merge(@service_url, "#{station}.xml") |> to_string()
  end

  def handle_response({:error, %HTTPoison.Response{status_code: status_code}}) do
    {:error, status_code}
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    {doc, []} = body |> String.to_charlist() |> :xmerl_scan.string()
    {:ok, get_paths(doc)}
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: status_code}}) do
    {:error, status_code}
  end

  def get_paths(doc) do
    Enum.map(@child_paths, fn {child_name, path} -> {child_name, get_path(doc, path)} end)
  end

  def get_path(doc, path) do
    case :xmerl_xpath.string(path, doc) do
      [element] ->
        xmlText(element, :value) |> to_string()

      _ ->
        ""
    end
  end
end
