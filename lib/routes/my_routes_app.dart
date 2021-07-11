import 'package:flutter/material.dart';
import 'package:navigator_2/views/book/book_details_screen.dart';
import 'package:navigator_2/views/book/book_list_screen.dart';
import 'package:navigator_2/views/unknown.dart';

const PARAM_CHAR = ':';

const homePath = bookListPath;
const bookListPath = '/book';
const bookDetailsPath = '/book/:id';
const bookSettingsPath = '/book/:id/settings';
const user = '/:user';
const userRepo = '/:user/:repo';
const userRepoSettings = '/:user/:repo/settings';
const userRepoSettingsBranches = '/:user/:repo/settings/branches';
const b = '/:user/:repo/:folder';
const pageNotFoundPath = '/404';

final Map<String, Widget> myRoutesMap = {
  homePath: BooksListScreen(),
  userRepoSettingsBranches: Center(child: Text('/*/*/settings/branches')),
  bookDetailsPath: BookDetailsScreen(),
  bookSettingsPath: Center(child:Text(bookSettingsPath)),
  user: Center(child:Text(user)),
  userRepo: Center(child:Text(userRepo)),
  userRepoSettings: Center(child:Text(userRepoSettings)),
  b: Center(child:Text(b)),
  pageNotFoundPath: UnknownScreen()
};
