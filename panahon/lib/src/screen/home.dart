// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:panahon/src/theme.dart';
import 'package:weather/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  final ThemeController themeController;
  Home(
    this.themeController, {
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String cityName = 'cebu';
  WeatherFactory _wf = WeatherFactory('dbefc4cc13f502139796b12c559d332d');
  late AssetImage bkgImage;
  ThemeController get _themeController => widget.themeController;

  late Weather _currentWeather;
  // late List<Weather> _fiveDayWeather;
  late List<dynamic> _hourlyWeather;
  late List<dynamic> _dailyWeather;

  @override
  void initState() {
    bkgImage = _themeController.backgroundSelector();

    // getWeather();
    super.initState();
  }

  var kExpandedHeight = 160.0;

  Future<String> _getWeather() async {
    try {
      _currentWeather = await _wf.currentWeatherByCityName(cityName);
      // _fiveDayWeather = await _wf.fiveDayForecastByCityName(cityName);
      // print(_fiveDayWeather);
      final url = Uri.https(
        'api.openweathermap.org',
        'data/2.5/onecall',
        {
          'lat': '10.3167',
          'lon': '123.8907',
          'exclude': 'minutely,current',
          'units': 'metric',
          'appid': 'dbefc4cc13f502139796b12c559d332d',
        },
      );

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        _hourlyWeather = jsonResponse['hourly'];
        _dailyWeather = jsonResponse['daily'];
      } else {}
      return "sucess";
    } catch (e) {
      return e.toString();
    }
  }

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
                future: _getWeather(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasError) {
                    Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 9,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Weather",
                                style: Theme.of(context).textTheme.headline2,
                                // textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          currentWeather(),
                          dailyWeather(),
                          miscellaneousWeather(),
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

  Widget miscellaneousWeather() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 200,
        // color: Colors.pink,
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text("UV Index"),
                  Text(
                    "Low",
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }

  Widget currentWeather() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Theme.of(context).textTheme.headline3?.color,
                      ),
                      Text(
                        _currentWeather.areaName.toString(),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                  Text(DateFormat("E, MMM d  hh:mm aaa")
                      .format(_currentWeather.date ?? DateTime.now())),
                ],
              ),
            ),

            Container(
              // color: Colors.pink,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 0),
                        height: 100,
                        width: 64,
                        // color: Colors.red,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Image.network(
                            "http://openweathermap.org/img/wn/" +
                                _currentWeather.weatherIcon.toString() +
                                "@2x.png",

                            // color: Colors.transparent,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          temperatureTrim(_currentWeather.temperature),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _currentWeather.weatherMain.toString(),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        temperatureTrim(_currentWeather.tempMin) +
                            "/" +
                            temperatureTrim(_currentWeather.tempMax),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        "Feels like " +
                            temperatureTrim(_currentWeather.tempFeelsLike),
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            hourlyWeather()
            // Text(_currentWeather.weatherDescription.toString()),
          ],
        ),
      ),
    );
  }

  Widget hourlyWeather() {
    return Container(
      // color: Colors.pink,
      padding: EdgeInsets.symmetric(horizontal: 16),
      // color: Colors.pink,
      height: 115,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 24,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 52,
            child: Column(
              children: [
                Text(
                  convertToHour(index),
                  style: Theme.of(context).textTheme.caption,
                ),
                Image.network(
                  "http://openweathermap.org/img/wn/" +
                      _hourlyWeather[index]["weather"][0]['icon'].toString() +
                      ".png",
                  fit: BoxFit.fitHeight,
                ),
                Text(
                  "${_hourlyWeather[index]['temp'].toInt()}°",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      ("${(_hourlyWeather[index]['pop'] * 100).toInt()}% "),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
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

  String convertToHour(index) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(_hourlyWeather[index]['dt'] * 1000);

    return DateFormat("h aaa").format(date).toString();
  }

  String convertToDayOfWeek(index) {
    return index == 0
        ? "Today"
        : DateFormat.EEEE()
            .format(DateTime.fromMillisecondsSinceEpoch(
                _dailyWeather[index]['dt'] * 1000))
            .toString();
  }
}
