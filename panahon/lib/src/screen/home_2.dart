// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field

import 'package:flutter/material.dart';

class Home2 extends StatefulWidget {
  Home2({Key? key}) : super(key: key);

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  late AssetImage bkgImage;
  late ScrollController _scrollController;
  @override
  void initState() {
    var dateNow = DateTime.now().hour;
    print(dateNow);
    if (dateNow > 18) {
      bkgImage = AssetImage("assets/background/nightsky.jpeg");
    } else if (dateNow > 15) {
      bkgImage = AssetImage("assets/background/afternoonsky.jpg");
    } else if (dateNow > 6) {
      bkgImage = AssetImage("assets/background/morningsky.jpg");
    } else if (dateNow > 4) {
      bkgImage = AssetImage("assets/background/afternoonsky.jpg");
    } else {
      bkgImage = AssetImage("assets/background/morningsky.jpg");
    }

    _scrollController = ScrollController()..addListener(() => setState(() {}));

    super.initState();
  }

  bool _floating = false;
  bool _pinned = true;
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
            alignment: Alignment.centerLeft,
          ),
          Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ],
              // pinned: _pinned,
              // snap: _snap,
              // floating: _floating,
              // expandedHeight: 160,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Text('Panahon'),
              // flexibleSpace: FlexibleSpaceBar(
              //   titlePadding: EdgeInsets.all(18),
              // ),
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: SizedBox(
                height: 1000,
                child: Card(
                  child: SizedBox(
                    width: double.infinity,
                    // child: Text("test"),
                  ),
                ),
              ),
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
                      //           //  ListTile(
                      //           //   title: Text(
                      //           //     "Cebu City",
                      //           //     style: Theme.of(context).textTheme.headline6,
                      //           //   ),
                      //           //   leading: Text("Tue, April 21 12:31 AM"),
                      //           //   trailing: Text('Trailing'),
                      //           // ),
                      //           ),
                      //     )
                      //   ],
                      // ),