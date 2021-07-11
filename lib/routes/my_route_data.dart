class MyRouteData {
  final String path;
  final List<String?> params;

  MyRouteData(this.path, {List<String>? params}): this.params = params ?? [];

  @override
  String toString() => 'path: $path | params: $params';
}
