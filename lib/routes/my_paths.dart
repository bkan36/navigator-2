import 'package:flutter/material.dart';
import 'package:navigator_2/views/book/book_details_screen.dart';
import 'package:navigator_2/views/book/book_list_screen.dart';
import 'package:navigator_2/views/unknown.dart';

// target /:bk/account/:jhfd/settings

const bookListPath = '/';
const bookDetailsPath = '/book/order/*';
const bookPath = '/book';
const homePath = bookListPath;
const dynamicPath = '/*/*/account/settings';
const b = '/*/*/*';
const pageNotFoundPath = '/404';

final Map<String, Widget> myRoutesMap = {
  bookListPath: BooksListScreen(),
  dynamicPath: Center(child: Text('/*/*/account/settings')),
  bookDetailsPath: BookDetailsScreen(),
  bookPath: Text('bokktest'),
  pageNotFoundPath: UnknownScreen()
};
