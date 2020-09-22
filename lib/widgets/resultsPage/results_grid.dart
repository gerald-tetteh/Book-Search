/*
  * Author: Gerald Addo-Tetteh
  * Book Search App
  * Results Grid
*/

/*
  This widget returns a grid view of the'
  results form the users search.
*/

import 'package:flutter/material.dart';

import '../../utils/text_util.dart';
import '../../utils/default_util.dart';
import '../../models/book_model.dart';

class ResultsGrid extends StatelessWidget {
  const ResultsGrid({
    Key key,
    @required this.bookItems,
    @required this.textUtil,
  }) : super(key: key);

  final List<BookModel> bookItems;
  final TextUtil textUtil;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (BuildContext ctx, int index) {
          var imgNotNull = bookItems[index].imageUrl != null;
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(DefaultUtil.borderRadiusValue2),
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(DefaultUtil.borderRadiusValue2),
              child: GridTile(
                footer: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Text(
                    bookItems[index].title,
                    style: textUtil.defaultStyle,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imgNotNull
                          ? NetworkImage(bookItems[index].imageUrl["thumbnail"])
                          : AssetImage(DefaultUtil.defaultImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        childCount: bookItems.length,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
    );
  }
}
