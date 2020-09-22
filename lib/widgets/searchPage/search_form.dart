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
import 'package:provider/provider.dart';

import '../../utils/text_util.dart';
import '../global/custom_button.dart';
import '../../models/book_model.dart';
import '../../screens/results_page.dart';

class SearchForm extends StatefulWidget {
  SearchForm({
    Key key,
  }) : super(key: key);
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  GlobalKey<FormState> _formKey;
  BookModelProvider bookProvider;
  String _searchtext;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    bookProvider = Provider.of<BookModelProvider>(context, listen: false);
    super.initState();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    final items = await bookProvider.searchBooks(_searchtext, true);
    Navigator.of(context).pushNamed(ResultsPage.routeName, arguments: {
      "bookItems": items,
      "searchText": _searchtext,
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final textUtil = TextUtil(mediaQuery);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Text(
                  "Book Search",
                  style: textUtil.mainHeading,
                ),
                Text(
                  "powered by Google Books",
                  textAlign: TextAlign.start,
                  style: textUtil.subHeading,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 30,
            ),
            child: Form(
              key: _formKey,
              child: TextFormField(
                autocorrect: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Title / Author",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter some text";
                  } else {
                    for (int i = 0; i < value.length; i++) {
                      if (!(value.codeUnitAt(i) >= 0) &&
                          !(value.codeUnitAt(i) <= 255)) {
                        return "Please enter a valid text";
                      }
                    }
                  }
                  return null;
                },
                onSaved: (newValue) => _searchtext = newValue,
              ),
            ),
          ),
          CustomButton(
            textUtil: textUtil,
            text: "Search",
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
