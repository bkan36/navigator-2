import 'package:flutter/material.dart';

import 'package:navigator_2/data/book_list.dart';
import 'package:navigator_2/routes/my_routes_app.dart';
import 'package:navigator_2/routes/my_route_path.dart';
import 'package:navigator_2/routes/my_router_delegate.dart';

import '../../entities/book_entity.dart';

class BooksListScreen extends StatelessWidget {
  late final List<Book?> books;

  BooksListScreen() : books = getAllBooks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          for (var book in books)
            ListTile(
              title: Text(book!.title),
              subtitle: Text(book.author),
              onTap: () => MyRouterDelegate()(
                  MyRouteData(bookDetailsPath, params: [book.id])),
            )
        ],
      ),
    );
  }
}
