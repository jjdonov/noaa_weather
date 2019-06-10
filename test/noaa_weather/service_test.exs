defmodule NoaaWeather.ServiceTest do
  use ExUnit.Case
  doctest NoaaWeather.Service

  alias NoaaWeather.Service

  @service_url Application.get_env(:noaa_weather, :service_url)

  test "station_url returns the expected URL for a station" do
    assert Service.station_url("PADK") === "#{@service_url}PADK.xml"
  end

  test "An :error response returns the status code" do
    assert Service.handle_response({:error, %HTTPoison.Response{status_code: 500}}) ==
             {:error, 500}
  end

  test "Any :ok response whose status code is not 200 returns an :error" do
    assert Service.handle_response({:ok, %HTTPoison.Response{status_code: 100}}) == {:error, 100}
    assert Service.handle_response({:ok, %HTTPoison.Response{status_code: 300}}) == {:error, 300}
    assert Service.handle_response({:ok, %HTTPoison.Response{status_code: 400}}) == {:error, 400}
    assert Service.handle_response({:ok, %HTTPoison.Response{status_code: 500}}) == {:error, 500}
  end
end
