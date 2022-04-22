// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:panahon/src/theme.dart';

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
  late AssetImage bkgImage;
  ThemeController get _themeController => widget.themeController;

  @override
  void initState() {
    bkgImage = _themeController.backgroundSelector();

    super.initState();
  }

  bool _floating = false;
  bool _pinned = false;
  bool _snap = false;
  var kExpandedHeight = 160.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Image(
            image: bkgImage,
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
              // pinned: _pinned,
              // snap: _snap,
              // floating: _floating,
              // expandedHeight: 160,
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
            body: CustomScrollView(
              slivers: [
                // SliverAppBar(
                //   pinned: _pinned,
                //   snap: _snap,
                //   floating: _floating,
                //   backgroundColor: Colors.transparent,
                //   expandedHeight: 80,
                //   flexibleSpace: FlexibleSpaceBar(
                //     expandedTitleScale: 1,
                //     // titlePadding: EdgeInsets.all(5),
                //     title: Text(
                //       'Weather',
                //       style: Theme.of(context).textTheme.headline2,
                //     ),
                //   ),
                // title: Container(
                //   padding: EdgeInsets.all(18),
                //   alignment: Alignment.center,
                //   child: Text(
                //     "Weather",
                //     style: Theme.of(context).textTheme.headline2,
                //   ),
                // ),
                // // backgroundColor: Colors.green,
                // actions: <Widget>[
                //   IconButton(
                //     icon: Icon(
                //       Icons.search,
                //       color: Theme.of(context).primaryColor,
                //     ),
                //     onPressed: () {},
                //   ),
                // ],
                // pinned: _pinned,
                // snap: _snap,
                // floating: _floating,
                // expandedHeight: 160,
                // backgroundColor: Colors.transparent,
                // elevation: 0.0,
                // flexibleSpace: FlexibleSpaceBar(
                //   expandedTitleScale: 1.6,
                //   titlePadding: EdgeInsets.all(18),
                //   title: Text(
                //     'Panahon',
                //     style: Theme.of(context).textTheme.headline5,
                //   ),
                // ),
                // ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      children: [
                        Container(
                          height: 120,
                          padding: EdgeInsets.all(15),
                          alignment: Alignment.center,
                          child: Text(
                            "Weather",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 800,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Cebu City",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    Text("Tue, April 21 12:31 AM"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "27°",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Fair',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                            Text(
                                              '32°/26°',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                            Text(
                                              "Feels like 32°",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //  ListTile(
                            //   title: Text(
                            //     "Cebu City",
                            //     style: Theme.of(context).textTheme.headline6,
                            //   ),
                            //   leading: Text("Tue, April 21 12:31 AM"),
                            //   trailing: Text('Trailing'),
                            // ),
                          ),
                        )
                      ],
                    ),
                    // SizedBox(
                    //   height: 200,
                    //   child: Card(),
                    // ),
                    // SizedBox(
                    //   height: 200,
                    //   child: Card(),
                    // ),
                    // SizedBox(
                    //   height: 200,
                    //   child: Card(),
                    // ),
                    // SizedBox(
                    //   height: 200,
                    //   child: Card(),
                    // ),
                    // SizedBox(
                    //   height: 200,
                    //   child: Card(),
                    // ),
                  ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

                      //  Column(
                      //   children: [
                      //     Container(
                      //       padding: EdgeInsets.all(10),
                      //       height: 800,
                      //       child: Card(
                      //           child: Padding(
                      //         padding: const EdgeInsets.all(18.0),
                      //         child: SizedBox(
                      //           width: double.infinity,
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Text(
                      //                 "Cebu City",
                      //                 style:
                      //                     Theme.of(context).textTheme.headline6,
                      //               ),
                      //               Text("Tue, April 21 12:31 AM"),
                      //               Row(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.spaceBetween,
                      //                 children: [
                      //                   Text(
                      //                     "27°",
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .headline3,
                      //                   ),
                      //                   Column(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.end,
                      //                     children: [
                      //                       Text(
                      //                         'Fair',
                      //                         style: Theme.of(context)
                      //                             .textTheme
                      //                             .caption,
                      //                       ),
                      //                       Text(
                      //                         '32°/26°',
                      //                         style: Theme.of(context)
                      //                             .textTheme
                      //                             .caption,
                      //                       ),
                      //                       Text(
                      //                         "Feels like 32°",
                      //                         style: Theme.of(context)
                      //                             .textTheme
                      //                             .caption,
                      //                       ),
                      //                     ],
                      //                   )
                      //                 ],
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       )
                                //  ListTile(
                                //   title: Text(
                                //     "Cebu City",
                                //     style: Theme.of(context).textTheme.headline6,
                                //   ),
                                //   leading: Text("Tue, April 21 12:31 AM"),
                                //   trailing: Text('Trailing'),
                                // ),
                      //           ),
                      //     )
                      //   ],
                      // ),