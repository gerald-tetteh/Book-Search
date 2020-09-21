/*
  * Author: Gerald Addo-Tetteh
  * Book Search App
  * Search Page
*/

/*
  This page contains a text field for the 
  user to enter the title of the book or
  the author.
*/

import 'package:flutter/material.dart';

import '../utils/color_util.dart';
import '../widgets/searchPage/search_form.dart';

class SearchPage extends StatelessWidget {
  static const routeName = "/search-page";
  @override
  Widget build(BuildContext context) {
    final mediQuery = MediaQuery.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: ColorUtil.searchPageGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Card(
            color: ColorUtil.white,
            margin: const EdgeInsets.all(15),
            child: Container(
              margin: const EdgeInsets.all(10),
              height: mediQuery.size.height * 0.5,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: ColorUtil.detailPageGradient,
              ),
              child: Center(child: SearchForm()),
            ),
          ),
        ),
      ),
    );
  }
}
