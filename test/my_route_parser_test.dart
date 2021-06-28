import 'package:flutter_test/flutter_test.dart';
import 'package:navigator_2/routes/my_paths.dart';
import 'package:navigator_2/routes/my_route_information_parser.dart';

void runTest(String path, {String? toMatch}) {
  final result = myRoutesParser(path);

  expect(result.path.values.first, toMatch ?? path);
}

void main() {
  group('parser route test', () {
    test('should return the home path', () => runTest(homePath));

    test('shoudl return 404 path',
        () => runTest('/fakepath', toMatch: pageNotFoundPath));

    test('should return a static nested path', () => runTest(bookPath));

    test('shoudl return a dynamic static path with 1 param',
        () => runTest('/book/order/20', toMatch: bookDetailsPath));

    test('shoudl return a dynamic nested path',
        () => runTest('/dynamic/path/account/settings', toMatch: dynamicPath));
  });
}
