import 'package:flutter/material.dart';
import '../views/book/book_details_screen.dart';
import '../views/book/book_list_screen.dart';
import '../views/unknown.dart';

const paramChar = ':';

const homePath = bookListPath;
const bookListPath = '/';
const bookDetailsPath = '/book/:id';
const bookSettingsPath = '/book/:id/settings';

const pageNotFoundPath = '/404';

final Map<String, Widget> myRoutesMap = {
  homePath: BooksListScreen(),
  bookDetailsPath: BookDetailsScreen(),
  bookSettingsPath: Center(child: Text(bookSettingsPath)),
  pageNotFoundPath: UnknownScreen()
};
