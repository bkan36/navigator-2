import 'package:flutter/material.dart';
import 'package:navigator_2/data/book_list.dart';
import 'package:navigator_2/routes/my_router_delegate.dart';

import '../../entities/book_entity.dart';

class BookDetailsScreen extends StatelessWidget {
  BookDetailsScreen();

  @override
  Widget build(BuildContext context) {
    var approute = MyRouterDelegate().currentConfiguration;
    Book? book = getBookById(approute!.params.first!);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book != null) ...[
              Text(book.title, style: Theme.of(context).textTheme.headline6),
              Text(book.id, style: Theme.of(context).textTheme.subtitle1),
              Text(book.author, style: Theme.of(context).textTheme.subtitle1),
            ],
            if (book == null) Text('BOOK NOT FOUND'),
          ],
        ),
      ),
    );
  }
}
