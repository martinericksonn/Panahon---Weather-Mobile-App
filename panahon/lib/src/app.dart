// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:panahon/src/screen/home.dart';
import 'package:panahon/src/theme.dart';

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  var theme = ThemeSelector();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: theme.themeSelector(context),
    );
  }
}
