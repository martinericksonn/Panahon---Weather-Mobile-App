import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:panahon/src/controllers/theme_controller.dart';

import 'package:weather/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class WeatherController {
  late final ThemeController themeController;
  late Weather currentWeather;
  late List<dynamic> hourlyWeather;
  late List<dynamic> dailyWeather;
  late String timeZone;
  late Map<String, dynamic> currentWeatherExtra;
  late String? cityName = 'lapu-lapu city';
  final key = '6994e452939894a4cf970d7fbafe71b8';
  late final WeatherFactory _wf;

  final StreamController<String?> _controller = StreamController();
  Stream<String?> get stream => _controller.stream;

  WeatherController() {
    // themeController = tc;
    _wf = WeatherFactory(key);
  }
  void setCity(String city) {
    cityName = city;
    getWeather();
  }

  void getWeather() async {
    _controller.add(null);
    tz.initializeTimeZones();

    try {
      if (cityName == null) {
        return;
      }
      print("IM BEING CALLED UPON!");
      currentWeather = await _wf.currentWeatherByCityName(cityName ?? 'none');

      final url = Uri.https(
        'api.openweathermap.org',
        'data/2.5/onecall',
        {
          'lat': currentWeather.latitude.toString(),
          'lon': currentWeather.longitude.toString(),
          'exclude': 'minutely',
          'units': 'metric',
          'appid': key,
        },
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);

        hourlyWeather = jsonResponse['hourly'];
        dailyWeather = jsonResponse['daily'];
        currentWeatherExtra = jsonResponse['current'];
        timeZone = jsonResponse['timezone'];

        // themeController.setTimeNow(getTimezoneHour());
        cityName = null;
        _controller.add("success");
        return;
      } else {
        _controller.addError(Future.error(response.statusCode));
        return;
      }
    } catch (e) {
      _controller.addError((e));
      return;
    }
  }

  String simplifyUV(uv) {
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
      return "Could not calculate UV";
    }
  }

  String temperatureTrim(var temperature) {
    return temperature.toString().replaceAll(" Celsius", "°");
  }

  String dateFormatHour(DateTime date) {
    return DateFormat(DateFormat.HOUR24).format(date).toString();
  }

  String dateFormatHourMeridiem(int timesamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timesamp * 1000);

    return DateFormat("h aaa").format(date).toString();
  }

  String dateFormatWeek(int timesamp, [int index = 0]) {
    return index == 0
        ? "Today"
        : DateFormat.EEEE()
            .format(DateTime.fromMillisecondsSinceEpoch(timesamp * 1000))
            .toString();
  }

  String dateFormatTimeOfDay(int timesamp) {
    return DateFormat('hh:mm aaa').format(
      DateTime.fromMillisecondsSinceEpoch(timesamp * 1000),
    );
  }

  DateTime getPSTTime() {
    try {
      final DateTime now = DateTime.now();
      final pacificTimeZone = tz.getLocation(timeZone);

      return tz.TZDateTime.from(now, pacificTimeZone);
    } catch (e) {
      return DateTime.now();
    }
  }

  int getTimezoneHour() {
    return int.parse(DateFormat(DateFormat.HOUR24).format(getPSTTime()));
  }
}
