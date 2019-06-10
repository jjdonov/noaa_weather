# Noaa

An implementation of an exercise from chatper 13 of "Programming Elixir":

>“In the United States, the National Oceanic and Atmospheric Administration provides hourly XML feeds of conditions at 1,800 locations.[24] For example, the feed for a small airport close to where I’m writing this is at http://w1.weather.gov/xml/current_obs/KDTO.xml.
> Write an application that fetches this data, parses it, and displays it in a nice format.”


## Packaging the command line utility

```
mix escript.build
```


## Example Output

```
$ ./noaa_weather PADK

location              |Adak Island, Adak Airport, AK
observation_time      |Last Updated on Jun 10 2019, 10:56 am HDT
temp_f                |47.0
relative_humidity     |74
weather               |Overcast
```
