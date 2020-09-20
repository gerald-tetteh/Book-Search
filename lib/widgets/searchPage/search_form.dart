/*
  * Author: Gerald Addo-Tetteh
  * Book Search App
  * Search Page
*/

/*
  This widget returns a column which shows
  the app title and the text field for the
  user to search for books.
*/

import 'package:flutter/material.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({
    Key key,
  }) : super(key: key);

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [],
      ),
    );
  }
}
