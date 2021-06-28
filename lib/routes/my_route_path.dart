class MyRoutePath {
  List<String?>? params = [];
  final Map<String, String> path;

  MyRoutePath({required this.path, this.params});

  @override
  String toString() => 'path: $path | params: $params';
}
