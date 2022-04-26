// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:panahon/src/screen/widgets/current_weather.dart';
import 'package:panahon/src/screen/widgets/dialy_weather.dart';
import 'package:panahon/src/theme_controller.dart';
import 'package:panahon/src/weather_controller.dart';
import 'package:weather/weather.dart';

// import 'dart:convert' as convert;
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  final ThemeController themeController;
  // final WeatherController weatherController;

  Home(
    this.themeController, {
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String cityName = 'lapu-lapu city';
  WeatherFactory _wf = WeatherFactory('dbefc4cc13f502139796b12c559d332d');
  late AssetImage bkgImage;
  late final WeatherController _weatherController;

  ThemeController get _themeController => widget.themeController;

  late Weather _currentWeather;
  // late List<Weather> _fiveDayWeather;
  late List<dynamic> _hourlyWeather;
  late List<dynamic> _dailyWeather;

  late Map<String, dynamic> _currentWeatherExtra;

  @override
  void initState() {
    bkgImage = _themeController.backgroundSelector();
    _weatherController = WeatherController();

    super.initState();
  }

  var kExpandedHeight = 160.0;

  String temperatureTrim(var temperature) {
    return temperature.toString().replaceAll(" Celsius", "°");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Image(
            image: bkgImage,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            alignment: _themeController.backgroundShift(),
          ),
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {},
                  ),
                ],
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1.6,
                  titlePadding: EdgeInsets.all(18),
                  title: Text(
                    'Panahon',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
              body: FutureBuilder(
                future: _weatherController.getWeather(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasError) {
                    Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.connectionState == ConnectionState.none) {
                    return Center(child: Text("No Internet Connection"));
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 10,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Weather",
                                style: Theme.of(context).textTheme.headline2,
                                // textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          CurrentWeather(wc: _weatherController),
                          DailyWeather(wc: _weatherController),

                          // dailyWeather(),
                          // miscellaneousWeather(),
                        ],
                      ),
                    );
                  }
                },
              )),
        ],
      ),
    );
  }

  String uvCalculator(uv) {
    if (uv >= 11) {
      return "Extemely High";
    } else if (uv > 7) {
      return "Very High";
    } else if (uv > 5) {
      return "High";
    } else if (uv > 2) {
      return "Medium";
    } else if (uv <= 2) {
      return "Low";
    } else {
      return "Could not calculate";
    }
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

  Widget dailyWeather() {
    return Container(
      height: 332,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: _dailyWeather.length,
            itemBuilder: ((context, index) {
              // print(_currentWeather.runtimeType);
              return Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 65,
                    child: Text(
                      convertToDayOfWeek(index),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              // color: Colors.pink,
                              height: 12,
                              alignment: Alignment.topCenter,
                              child: Icon(
                                Icons.water_drop_outlined,
                                size: 8,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            Text(
                              ("${(_dailyWeather[index]['pop'] * 100).toInt()}% "),
                              style: Theme.of(context).textTheme.caption,
                              // _dailyWeather[index]['rain'].toString() + "%",
                            ),
                          ],
                        ),
                        SizedBox(
                          // color: Colors.pink,
                          height: 38,
                          child: Image.network(
                            "http://openweathermap.org/img/wn/" +
                                _dailyWeather[index]["weather"][0]['icon']
                                    .toString() +
                                ".png",
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        // Text(_dailyWeather[index]["weather"][0]['main']),
                        Text(
                          temperatureTrim(
                                  '${_dailyWeather[index]['temp']['max'].toInt()}°') +
                              "/" +
                              temperatureTrim(
                                  '${_dailyWeather[index]['temp']['min'].toInt()}°'),
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    // color: Colors.pink,
                    width: 90,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        _dailyWeather[index]["weather"][0]['description']
                            .toString(),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  String convertToDayOfWeek(index) {
    return index == 0
        ? "Today"
        : DateFormat.EEEE()
            .format(DateTime.fromMillisecondsSinceEpoch(
                _dailyWeather[index]['dt'] * 1000))
            .toString();
  }

  String convertToTimeOfDay(index) {
    return index == 0
        ? "Today"
        : DateFormat.QQQ()
            .format(DateTime.fromMillisecondsSinceEpoch(
                _dailyWeather[index]['dt'] * 1000))
            .toString();
  }
}
