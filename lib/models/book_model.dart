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

import 'package:http/http.dart' as http;

import '../keys/api_keys.dart';

class BookModel {
  final String title;
  final String author;
  final String publisher;
  final String publishDate;
  final String description;
  final String viewLink;
  final String imageUrl;

  BookModel({
    this.title,
    this.author,
    this.publisher,
    this.publishDate,
    this.description,
    this.viewLink,
    this.imageUrl,
  });
}

class BookModelProvider {
  /*
    Searches for books based on the users
    input.
  */
  static Future<List<BookModel>> searchBooks(
      String input, String startIndex) async {
    final searchParams = input.trim().split(" ").join("+");
    print(searchParams);
    final url =
        "https://www.googleapis.com/books/v1/volumes?q=$searchParams&startIndex=$startIndex&maxResults=40&key=${ApiKeys.booksApiKey}";
    final finalUrl = Uri.encodeFull(url);
    print(finalUrl);
    try {
      final response = await http.get(finalUrl);
      print(response);
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      print(jsonData);
      final responseItems = jsonData["items"] as List<dynamic>;
      print(responseItems);
      if (responseItems == null) {
        return null;
      } else {
        return responseItems
            .map((item) => BookModel(
                  title: item["volumeInfo"]["title"],
                  author: item["volumeInfo"]["authors"][0],
                  publisher: item["volumeInfo"]["publisher"],
                  publishDate: item["volumeInfo"]["publishedDate"],
                  description: item["volumeInfo"]["description"],
                  imageUrl: item["volumeInfo"]["imageLinks"]["thumbnail"],
                  viewLink: item["volumeInfo"]["previewLink"],
                ))
            .toList();
      }
    } catch (error) {
      print(error);
      return null;
    }
  }
}
