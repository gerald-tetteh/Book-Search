/*
  * Author: Gerald Addo-Tetteh
  * Book Search App
  * Main File
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './screens/search_page.dart';
import './screens/results_page.dart';
import './screens/detail_page.dart';
import './models/book_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
      create: (ctx) => BookModelProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Book Search',
        theme: ThemeData(
          fontFamily: "FiraSans",
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SearchPage(),
        routes: {
          ResultsPage.routeName: (ctx) => ResultsPage(),
          SearchPage.routeName: (ctx) => SearchPage(),
          BookDetailPage.routeName: (ctx) => BookDetailPage(),
        },
      ),
    );
  }
}
