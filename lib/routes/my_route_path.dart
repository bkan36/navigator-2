class MyRoutePath {
  final String path;
  final List<String?> params;
  String dynamicPath;

  MyRoutePath(this.path, {List<String>? params, String? dynamicPath})
      : this.params = params ?? [],
        this.dynamicPath = dynamicPath ?? '';

  @override
  String toString() =>
      'path: $path | params: $params | pathToDisplay: $dynamicPath';
}
