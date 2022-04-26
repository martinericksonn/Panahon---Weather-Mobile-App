// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:panahon/src/screen/widgets/current_weather.dart';
import 'package:panahon/src/screen/widgets/dialy_weather.dart';
import 'package:panahon/src/screen/widgets/micesllaneous_weather.dart';
import 'package:panahon/src/theme_controller.dart';
import 'package:panahon/src/weather_controller.dart';

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
  late AssetImage bkgImage;
  late final WeatherController _weatherController;
  ThemeController get _themeController => widget.themeController;

  @override
  void initState() {
    // bkgImage = _themeController.backgroundSelector();
    _weatherController = WeatherController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Image(
            image: _themeController.backgroundSelector(),
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
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasError) {
                  Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  return Center(child: Text("No Internet Connection"));
                } else {
                  return weatherCards(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView weatherCards(BuildContext context) {
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
          MiscellaneousWeather(wc: _weatherController, context: context)

          // dailyWeather(),
          // miscellaneousWeather(),
        ],
      ),
    );
  }
}
