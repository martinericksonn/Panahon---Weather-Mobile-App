import 'package:flutter/material.dart';
import 'package:panahon/src/theme_controller.dart';

class SearchScreen extends StatelessWidget {
  final ThemeController themeController;
  const SearchScreen({Key? key, required this.themeController})
      : super(key: key);

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
              backgroundColor: Colors.transparent,
              elevation: 0,
              // The search area here
              title: Container(
                child: Center(
                  child: TextField(
                    style: Theme.of(context).textTheme.headline5,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      hintStyle: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
              )),
          // body: const Text("Hello World"),
        ),
      ],
    ));
  }
}
