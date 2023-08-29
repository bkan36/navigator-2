import 'package:flutter_test/flutter_test.dart';
import 'package:navigator_2/routes/my_routes_app.dart';
import 'package:navigator_2/routes/my_route_information_parser.dart';

void runTest(String path, {String? toMatch}) {
  final result = myRoutesParser(Uri.parse(path));

  expect(result.path, toMatch ?? path);

  if (toMatch != null && toMatch.endsWith(paramChar))
    expect(result.params, isNotEmpty);
}

void main() {
  group('parser route test', () {
    test('should return the home path', () => runTest(homePath));

    test('should return 404 path',
        () => runTest('/book/to/fail/e', toMatch: pageNotFoundPath));

    test('should return a static nested path', () => runTest(bookSettingsPath));

    test('should return a path with 1 param',
        () => runTest('/book/20', toMatch: bookDetailsPath));
  });
}
