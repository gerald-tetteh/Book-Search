/*
  * Author: Gerald Addo-Tetteh
  * Book Search App
  * Book Model
*/

/*
  This class is the model for a book item.
  It contains methos to retrieve and decode JSON data from 
  the google books api.
*/
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../keys/api_keys.dart';

class BookModel {
  final String title;
  final List<dynamic> author;
  final String publisher;
  final String publishDate;
  final String description;
  final String viewLink;
  final Map<String, dynamic> imageUrl;

  BookModel({
    this.title,
    this.author,
    this.publisher,
    this.publishDate,
    this.description,
    this.viewLink,
    this.imageUrl,
  });

  @override
  String toString() {
    return this.title;
  }
}

class BookModelProvider with ChangeNotifier {
  // index is used to control pagnation.
  int startIndex = 0;
  List<BookModel> _books = [];

  /*
    Searches for books based on the users
    input.
  */
  Future<List<BookModel>> searchBooks(String input,
      [bool newSearch = false]) async {
    startIndex = newSearch ? 0 : startIndex;
    final searchParams = input.trim().split(" ").join("+");
    final url =
        "https://www.googleapis.com/books/v1/volumes?q=$searchParams&startIndex=$startIndex&maxResults=40&key=${ApiKeys.booksApiKey}";
    final finalUrl = Uri.encodeFull(url);
    try {
      final response = await http.get(finalUrl);
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      final responseItems = jsonData["items"] as List<dynamic>;
      final possibleError = jsonData["error"] as Map<String, dynamic>;
      if (possibleError != null) {
        return null;
      }
      if (responseItems == null) {
        Fluttertoast.showToast(
          msg: "This is Center Short Toast",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return [..._books];
      } else {
        startIndex += 40;
        var bookModels = responseItems
            .map((item) => BookModel(
                  title: item["volumeInfo"]["title"],
                  author: item["volumeInfo"]["authors"],
                  publisher: item["volumeInfo"]["publisher"],
                  publishDate: item["volumeInfo"]["publishedDate"],
                  description: item["volumeInfo"]["description"],
                  imageUrl: item["volumeInfo"]["imageLinks"],
                  viewLink: item["volumeInfo"]["previewLink"],
                ))
            .toList();
        _books = bookModels;
        return bookModels;
      }
    } catch (error) {
      return null;
    }
  }

  // change start index
  void setStartIndex(int number) => startIndex = number;
}
