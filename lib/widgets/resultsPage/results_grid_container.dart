/*
  * Author: Gerald Addo-Tetteh
  * Book Search App
  * Results grid Container
*/

/*
  This widget returns a custom scroll view
  which shows te grid view and the naviagtion
  buttons.
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global/custom_button.dart';
import '../../models/book_model.dart';
import '../../utils/text_util.dart';
import '../../utils/color_util.dart';
import 'results_grid.dart';
import 'navigation_buttons.dart';

class ResultsGridContainer extends StatefulWidget {
  const ResultsGridContainer({
    Key key,
    @required this.actualHeight,
    @required this.bookItems,
    @required this.textUtil,
    @required this.searchText,
  }) : super(key: key);

  final double actualHeight;
  final List<BookModel> bookItems;
  final TextUtil textUtil;
  final String searchText;

  @override
  _ResultsGridContainerState createState() => _ResultsGridContainerState();
}

class _ResultsGridContainerState extends State<ResultsGridContainer> {
  BookModelProvider bookProvider;
  var isLoading = false;
  List<BookModel> bookItems;

  @override
  void initState() {
    super.initState();
    bookProvider = Provider.of<BookModelProvider>(context, listen: false);
    bookItems = widget.bookItems;
  }

  Future<void> _retry() async {
    await _next();
  }

  Future<void> _next() async {
    setState(() => isLoading = true);
    final items = await bookProvider.searchBooks(widget.searchText);
    setState(() {
      bookItems = items;
      isLoading = false;
    });
  }

  Future<void> _previous() async {
    setState(() => isLoading = true);
    bookProvider.setStartIndex(bookProvider.startIndex - 80);
    final items = await bookProvider.searchBooks(widget.searchText);
    setState(() {
      bookItems = items;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      height: widget.actualHeight * 0.7,
      color: ColorUtil.silverWhite,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : bookItems != null
              ? CustomScrollView(
                  slivers: [
                    ResultsGrid(
                      bookItems: bookItems,
                      textUtil: widget.textUtil,
                    ),
                    NavigationButtons(
                      textUtil: widget.textUtil,
                      nextFunction: _next,
                      bookProvider: bookProvider,
                      previousFunction: _previous,
                    ),
                  ],
                )
              : Center(
                  child: CustomButton(
                    text: "Click to retry: An error occured.",
                    textUtil: widget.textUtil,
                    onPressed: _retry,
                  ),
                ),
    );
  }
}
