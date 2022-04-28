import 'dart:math';

import 'package:flutter/material.dart';
import 'package:panahon/src/theme_controller.dart';

import '../weather_controller.dart';

class SearchScreen extends StatelessWidget {
  final ThemeController themeController;
  final WeatherController weatherController;

  SearchScreen({
    Key? key,
    required this.themeController,
    required this.weatherController,
  }) : super(key: key);

  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        Image(
          image: themeController.backgroundSelector(),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          alignment: themeController.backgroundShift(),
        ),
        Scaffold(
          backgroundColor: Theme.of(context).cardTheme.color,
          appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    weatherController.setCity(_textEditingController.text);
                    Navigator.of(context).pop(_textEditingController.text);
                    // print(_textEditingController.value.toString());
                  },
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0,
              // The search area here
              title: Center(
                child: TextField(
                  autofocus: true,
                  onSubmitted: (_textEditingController) {
                    Random random = Random();
                    int randomNumber = random.nextInt(24);
                    themeController.setTimeNow(randomNumber);

                    weatherController.setCity(this._textEditingController.text);
                    Navigator.of(context).pop(this._textEditingController.text);
                  },
                  controller: _textEditingController,
                  style: Theme.of(context).textTheme.headline5,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              )),
          // body: const Text("Hello World"),
        ),
      ],
    ));
  }
}
