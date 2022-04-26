import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:panahon/src/theme_controller.dart';
import 'package:weather/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class WeatherController {
  late Weather currentWeather;
  late List<dynamic> hourlyWeather;
  late List<dynamic> dailyWeather;
  late Map<String, dynamic> currentWeatherExtra;

  Future<String> getWeather() async {
    String cityName = 'lapu-lapu city';
    WeatherFactory _wf = WeatherFactory('dbefc4cc13f502139796b12c559d332d');

    try {
      currentWeather = await _wf.currentWeatherByCityName(cityName);

      final url = Uri.https(
        'api.openweathermap.org',
        'data/2.5/onecall',
        {
          'lat': '10.3167',
          'lon': '123.8907',
          'exclude': 'minutely',
          'units': 'metric',
          'appid': 'dbefc4cc13f502139796b12c559d332d',
        },
      );

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        hourlyWeather = jsonResponse['hourly'];
        dailyWeather = jsonResponse['daily'];
        currentWeatherExtra = jsonResponse['current'];
      } else {
        // throw HttpRequestEventTarget.errorEvent;
      }

      return "sucess";
    } catch (e) {
      return e.toString();
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
      return "Could not calculate";
    }
  }

  String temperatureTrim(var temperature) {
    return temperature.toString().replaceAll(" Celsius", "°");
  }

  String dateFormatHour(int timesamp) {
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
}
