/*
  * Author: Gerald Addo-Tetteh
  * Book Search App
  * Results Page
*/

/*
  This page shoes the results from the users search
  in a grid. Each grid tile conatines the cover of the image
  and the tile and author of the book.
*/

import 'package:flutter/material.dart';

import '../models/book_model.dart';
import '../utils/color_util.dart';
import '../utils/default_util.dart';
import '../utils/text_util.dart';
import '../widgets/resultsPage/results_grid_container.dart';

class ResultsPage extends StatelessWidget {
  static const routeName = "/results-page";
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final bookItems = arguments["bookItems"] as List<BookModel>;
    final searchText = arguments["searchText"] as String;
    final mediaQuery = MediaQuery.of(context);
    final viewHeight = mediaQuery.size.height;
    final extraPadding = mediaQuery.padding.bottom;
    final actualHeight = viewHeight - extraPadding;
    final textUtil = TextUtil(mediaQuery);
    return Scaffold(
      backgroundColor: ColorUtil.silverWhite,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: actualHeight * 0.3,
            decoration: BoxDecoration(
              gradient: ColorUtil.resultPageGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(DefaultUtil.borderRadiusValue),
                bottomRight: Radius.circular(DefaultUtil.borderRadiusValue),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Results",
                  style: textUtil.heading2,
                ),
                Text(
                  "from",
                  style: textUtil.subHeading2,
                ),
                Text(
                  "'$searchText'",
                  style: textUtil.searchText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                FlatButton.icon(
                  icon: Icon(Icons.search),
                  label: Text(
                    "New Search",
                  ),
                  onPressed: Navigator.of(context).pop,
                ),
              ],
            ),
          ),
          ResultsGridContainer(
            actualHeight: actualHeight,
            bookItems: bookItems,
            textUtil: textUtil,
            searchText: searchText,
          ),
        ],
      ),
    );
  }
}
