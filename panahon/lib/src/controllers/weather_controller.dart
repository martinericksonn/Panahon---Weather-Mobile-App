import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:weather/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class WeatherController with ChangeNotifier {
  late Weather currentWeather;
  late List<dynamic> hourlyWeather;
  late List<dynamic> dailyWeather;
  late String timeZone;
  late Map<String, dynamic> currentWeatherExtra;
  late String cityName = 'lapu-lapu city';
  final WeatherFactory _wf = WeatherFactory('dbefc4cc13f502139796b12c559d332d');

  void setCity(String city) {
    cityName = city;
    notifyListeners();
  }

  Stream<String> getWeather() {
    tz.initializeTimeZones();
    late final StreamController<String> controller;
    controller = StreamController<String>(
      onListen: () async {
        try {
          currentWeather = await _wf.currentWeatherByCityName(cityName);

          final url = Uri.https(
            'api.openweathermap.org',
            'data/2.5/onecall',
            {
              'lat': currentWeather.latitude.toString(),
              'lon': currentWeather.longitude.toString(),
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
            timeZone = jsonResponse['timezone'];

            controller.add("success");
            return;
          } else {
            controller.addError(Future.error(response.statusCode));
            return;
          }
        } catch (e) {
          controller.addError((e));
          return;
        }
      },
    );

    return controller.stream;
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
      print(e);
      return DateTime.now();
    }
  }
}
