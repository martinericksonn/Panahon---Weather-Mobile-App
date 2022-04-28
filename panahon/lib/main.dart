import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:panahon/src/app.dart';
import 'package:timezone/timezone.dart';

void main() async {
  // var byteData = await rootBundle?.load('assets/2021e.tzf');
  // if (byteData != null) {
  //   initializeDatabase(byteData.buffer.asUint8List());
  // }
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
