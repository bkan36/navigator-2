import 'package:flutter/material.dart';
import 'package:navigator_2/views/book/book_details_screen.dart';
import 'package:navigator_2/views/book/book_list_screen.dart';
import 'package:navigator_2/views/unknown.dart';

// target /:bk/account/:jhfd/settings

const PARAM_CHAR = ':';

const homePath = bookListPath;
const bookListPath = '/';
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
  bookSettingsPath: Center(child:Text('/book')),
  user: Center(child:Text(user)),
  userRepo: Center(child:Text(userRepo)),
  userRepoSettings: Center(child:Text(userRepoSettings)),
  pageNotFoundPath: UnknownScreen()
};
