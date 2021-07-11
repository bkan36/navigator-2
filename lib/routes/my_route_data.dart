class MyRouteData {
  final String path;
  final Map<String, String> params;

  MyRouteData(this.path, {Map<String, String>? params}): this.params = params ?? {};

  @override
  String toString() => 'path: $path | params: $params';
}
