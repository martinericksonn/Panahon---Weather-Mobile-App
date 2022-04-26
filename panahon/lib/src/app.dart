// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:panahon/src/screen/home.dart';

import 'package:panahon/src/theme_controller.dart';

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  var themeController = ThemeController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(themeController),
      theme: themeController.themeSelector(context),
    );
  }
}
