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

  late List<Weather> _fiveDayWeather;
  late Weather _currentWeather;
  late List<dynamic> _hourlyWeather;
  late List<dynamic> _dailyWeather;

  @override
  void initState() {
    bkgImage = _themeController.backgroundSelector();
    // getWeather();
    super.initState();
  }

  // bool _floating = false;
  // bool _pinned = false;
  // bool _snap = false;
  var kExpandedHeight = 160.0;

  Future<String> _getWeather() async {
    try {
      _currentWeather = await _wf.currentWeatherByCityName(cityName);
      _fiveDayWeather = await _wf.fiveDayForecastByCityName(cityName);
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

        print(jsonResponse.runtimeType);
        _hourlyWeather = jsonResponse['hourly'];
        _dailyWeather = jsonResponse['daily'];
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
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
                // pinned: _pinned,
                // snap: _snap,
                // floating: _floating,
                // expandedHeight: 160,
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
                    return Column(
                      children: [
                        currentWeather(),
                        Expanded(child: listBuilder()),
                      ],
                    );
                  }
                },
              )),
        ],
      ),
    );
  }

  Widget currentWeather() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on),
                  Text(
                    _currentWeather.areaName.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              Text(
                  // _currentWeather.date.toString(),
                  DateFormat("E, MMM d  hh:mm aaa")
                      .format(_currentWeather.date ?? DateTime.now())
                  // DateFormat.yMMMEd()
                  // .format(_currentWeather.date ?? DateTime.now()),
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 0),
                          height: 102,
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
                  )
                ],
              ),
              // Text(_currentWeather.weatherDescription.toString()),
            ],
          ),
        ),
      ),
    );
  }

  String convertToHour(index) {
    return DateFormat("h aaa")
        .format(DateTime.fromMillisecondsSinceEpoch(
            _hourlyWeather[index]['dt'] * 1000))
        .toString();
  }

  String convertToDayOfWeek(index) {
    return DateFormat.EEEE()
        .format(DateTime.fromMillisecondsSinceEpoch(
            _dailyWeather[index]['dt'] * 1000))
        .toString();
  }

  Widget listBuilder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
      child: Card(
        child: ListView.builder(
          itemCount: _dailyWeather.length - 1,
          itemBuilder: ((context, index) {
            // print(_currentWeather.runtimeType);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(convertToDayOfWeek(index + 1)),
                  Row(
                    children: [
                      Text(_dailyWeather[index]['rain'].toString()[0] + "%"),
                      Image.network(
                        "http://openweathermap.org/img/wn/" +
                            _dailyWeather[index]["weather"][0]['icon']
                                .toString() +
                            ".png",
                      ),
                      Text(
                        temperatureTrim(
                                '${_dailyWeather[index]['temp']['max'].toInt()}°') +
                            "/" +
                            temperatureTrim(
                                '${_dailyWeather[index]['temp']['min'].toInt()}°'),
                      )
                    ],
                  ),
                  Text(_dailyWeather[index]["weather"][0]['main']),

                  // DateFormat("E, MMM d  hh:mm aaa").format(
                  // DateTime(

                  // ),
                  // ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
