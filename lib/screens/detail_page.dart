/*
  * Author: Gerald Addo-Tetteh
  * Book Search App
  * Detail Page
*/

/*
  This page shows the title, author,
  book details, cover art and a link to
  the book page on Google books.
*/

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/book_model.dart';
import '../utils/text_util.dart';
import '../utils/color_util.dart';
import '../utils/default_util.dart';

class BookDetailPage extends StatelessWidget {
  Future<void> _openLink(String url, GlobalKey<ScaffoldState> scaffoldKey,
      TextUtil textUtil) async {
    scaffoldKey.currentState.showSnackBar(
      createSnackBar(
        textUtil,
        "Loading",
        Duration(hours: 2),
      ),
    );
    if (await canLaunch(url)) {
      await launch(url);
      scaffoldKey.currentState.removeCurrentSnackBar();
    } else {
      createSnackBar(
        textUtil,
        "Could not open page",
        Duration(seconds: 3),
      );
    }
  }

  SnackBar createSnackBar(TextUtil textUtil, String text, Duration duration) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: ColorUtil.buttonColor,
      margin: const EdgeInsets.all(8),
      content: Text(
        text,
        style: textUtil.defaultStyle,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DefaultUtil.borderRadiusValue),
      ),
      duration: duration,
    );
  }

  static const routeName = "/detail-page";
  @override
  Widget build(BuildContext context) {
    final bookModel = ModalRoute.of(context).settings.arguments as BookModel;
    final mediaQuery = MediaQuery.of(context);
    final viewHeight = mediaQuery.size.height;
    final extraPadding = mediaQuery.padding.bottom;
    final actualHeight = viewHeight - extraPadding;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final textUtil = TextUtil(mediaQuery);
    var imgNotNull = bookModel.imageUrl != null;
    var author = bookModel.author != null ? bookModel.author[0] : "Unknown";
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          Container(
            height: actualHeight * 0.40,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: ColorUtil.silverWhite,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft:
                          Radius.circular(DefaultUtil.borderRadiusValueLarge),
                    ),
                    gradient: ColorUtil.detailPageGradient,
                  ),
                  child: Hero(
                    tag: bookModel.viewLink,
                    child: Image(
                      image: imgNotNull
                          ? NetworkImage(bookModel.imageUrl["thumbnail"])
                          : AssetImage(DefaultUtil.defaultImage),
                    ),
                  ),
                ),
                Positioned(
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  top: 0,
                  left: 0,
                  right: 0,
                ),
              ],
            ),
          ),
          Container(
            height: actualHeight * 0.60,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: ColorUtil.detailPageGradientReversed,
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: ColorUtil.silverWhite,
                    borderRadius: BorderRadius.only(
                      topRight:
                          Radius.circular(DefaultUtil.borderRadiusValueLarge),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: mediaQuery.size.width * 0.4,
                            child: Text(
                              bookModel.title ?? "Unknown",
                              style: textUtil.bookDetailTitle,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Spacer(),
                          FlatButton.icon(
                            color: ColorUtil.buttonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                DefaultUtil.borderRadiusValue,
                              ),
                            ),
                            icon: Icon(
                              Icons.book_outlined,
                            ),
                            label: Text(
                              "View on Google",
                              style: textUtil.viewOnGoogle,
                            ),
                            onPressed: () => _openLink(
                              bookModel.viewLink,
                              _scaffoldKey,
                              textUtil,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "by $author",
                        style: textUtil.defaultStyle.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            bookModel.description ??
                                "Deatils are not available",
                            style: textUtil.descriptionStyle,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
