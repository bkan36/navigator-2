class Book {
  final String id;
  final String title;
  final String author;

  Book(this.id, this.title, this.author);

  @override
  String toString() => 'id: $id | title: $title | author: $author';
}