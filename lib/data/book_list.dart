import 'package:navigator_2/entities/book_entity.dart';

final List<Book?> booksList = [
  Book('1', 'Left Hand of Darkness', 'Ursula K. Le Guin'),
  Book('2', 'Too Like the Lightning', 'Ada Palmer'),
  Book('3', 'Kindred', 'Octavia E. Butler'),
];

List<Book?> getAllBooks() => booksList;

Book? getBookById(String id) {
  return booksList.firstWhere((book) => book!.id == id, orElse: () => null);
}
