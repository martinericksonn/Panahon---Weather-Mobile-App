// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:panahon/src/screen/search_screen.dart';
import 'package:panahon/src/screen/widgets/app_footer.dart';
import 'package:panahon/src/screen/widgets/current_weather.dart';
import 'package:panahon/src/screen/widgets/dialy_weather.dart';
import 'package:panahon/src/screen/widgets/micesllaneous_weather.dart';
import 'package:panahon/src/theme_controller.dart';
import 'package:panahon/src/weather_controller.dart';

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
  late final WeatherController _weatherController;
  ThemeController get _themeController => widget.themeController;

  @override
  void initState() {
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
                  onPressed: () {
                    citySearch();
                  },
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
            body: StreamBuilder(
              stream: _weatherController.getWeather(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.none:
                    return Center(child: Text("No Internet Connection"));
                  default:
                    Center(child: Text("Something is wrong"));
                }

                if (!snapshot.hasData && snapshot.hasError) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '"${_weatherController.cityName}" not found',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'Try searching for a city name',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
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

  void citySearch() async {
    String? cityName = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchScreen(
          themeController: _themeController,
          weatherController: _weatherController,
        ),
      ),
    );

    if (cityName != null) {
      setState(() {});
    }
  }

  SingleChildScrollView weatherCards(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // appHeadline(context),
            CurrentWeather(wc: _weatherController),
            DailyWeather(wc: _weatherController),
            MiscellaneousWeather(wc: _weatherController, context: context),
            AppFooter(),
          ],
        ),
      ),
    );
  }

  SizedBox appHeadline(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 10,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          "Weather",
          style: Theme.of(context).textTheme.headline2,
          // textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
