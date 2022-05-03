import 'package:flutter/material.dart';
import '../controllers/recent_search_controller.dart';
import '../controllers/theme_controller.dart';
import '../controllers/weather_controller.dart';

class SearchScreen extends StatefulWidget {
  final ThemeController themeController;
  final WeatherController weatherController;

  const SearchScreen({
    Key? key,
    required this.themeController,
    required this.weatherController,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final RecentSearchController recentSearchController =
      RecentSearchController();

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        Image(
          image: widget.themeController.backgroundSelector(),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          alignment: widget.themeController.backgroundShift(),
        ),
        Scaffold(
            backgroundColor: Theme.of(context).cardTheme.color,
            appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () => setCity(context, _textEditingController),
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
                      setCity(context, this._textEditingController);
                      // Random random = Random();
                      // int randomNumber = random.nextInt(24);
                      // themeController.setTimeNow(randomNumber);
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
            body: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: recentSearchController.searches.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () =>
                      setCity(context, recentSearchController.searches[index]),
                  title: Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        recentSearchController.searches[index],
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                      onPressed: () => setState(() {
                            recentSearchController.remove(index);
                          }),
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).primaryColor,
                      )),
                );
              },
            )
            // body: const Text("Hello World"),
            ),
      ],
    ));
  }

  void setCity(
      BuildContext context, TextEditingController textEditingController) {
    recentSearchController.add(textEditingController.text);
    Navigator.of(context).pop(textEditingController.text);
  }
}
