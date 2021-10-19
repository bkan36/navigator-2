class MyRouteData {
  final String path;
  final Map<String, dynamic> params;

  MyRouteData(this.path, {Map<String, dynamic>? params}): this.params = params ?? {};

  @override
  String toString() => 'path: $path | params: $params';
}
