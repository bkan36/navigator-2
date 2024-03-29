import 'package:flutter/material.dart';
import 'package:navigator_2/data/book_list.dart';
import 'package:navigator_2/routes/my_router_delegate.dart';

import '../../entities/book_entity.dart';

class BookDetailsScreen extends StatelessWidget {
  BookDetailsScreen();

  @override
  Widget build(BuildContext context) {
    var approute = goRoute.currentConfiguration;
    Book? book = getBookById(approute!.params['id']!);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book != null) ...[
              Text(book.title),
              Text(book.id),
              Text(book.author),
            ],
            if (book == null) Text('BOOK NOT FOUND'),
            SizedBox(height: 80.0),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('BACK'),
            )
          ],
        ),
      ),
    );
  }
}
