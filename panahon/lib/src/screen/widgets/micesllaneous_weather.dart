import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class MiscellaneousWeather extends StatelessWidget {
  final WeatherController wc;
  const MiscellaneousWeather({
    Key? key,
    required this.wc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget miscellaneousWeather() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
      child: Container(
        height: 290,
        // color: Colors.pink,
        child: Card(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: Column(
            children: [
              customTileList(
                WeatherIcons.day_sunny,
                "UV Light",
                uvCalculator(
                  _currentWeatherExtra['uvi'],
                ),
              ),
              customTileList(
                WeatherIcons.sunrise,
                "Sunrise",
                DateFormat('hh:mm aaa').format(
                  DateTime.fromMillisecondsSinceEpoch(
                      _currentWeatherExtra['sunrise'] * 1000),
                ),
              ),
              customTileList(
                WeatherIcons.sunset,
                "Sunset",
                DateFormat('hh:mm aaa').format(
                  DateTime.fromMillisecondsSinceEpoch(
                      _currentWeatherExtra['sunset'] * 1000),
                ),
              ),
              customTileList(
                WeatherIcons.humidity,
                "Humidity",
                (_currentWeatherExtra['humidity']).toString() + "%",
              ),
              customTileList(
                WeatherIcons.cloud,
                "Cloudiness",
                _currentWeatherExtra['clouds'].toString() + "%",
              ),
              customTileList(
                WeatherIcons.windy,
                "Wind Speed",
                _currentWeatherExtra['wind_speed'].toString() + " m/s",
              ),
              customTileList(
                WeatherIcons.barometer,
                "Pressure",
                _currentWeatherExtra['pressure'].toString() + " hPa",
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget customTileList(IconData icon, String title, String result) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 38,
          child: Row(
            children: [
              BoxedIcon(
                icon,
                size: 18,
                color: Theme.of(context).textTheme.headline3?.color,
              ),
              SizedBox(
                width: 3,
              ),
              Text(title),
            ],
          ),
        ),
        Text(
          result,
        ),
      ],
    );
  }
}
