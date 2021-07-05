import 'package:flutter_test/flutter_test.dart';
import 'package:navigator_2/routes/my_routes_app.dart';
import 'package:navigator_2/routes/my_route_information_parser.dart';

void runTest(String path, {String? toMatch}) {
  final result = myRoutesParser(path);

  expect(result.path, toMatch ?? path);

  if (toMatch != null && toMatch.endsWith(PARAM_CHAR))
    expect(result.params, isNotEmpty);
}

void main() {
  group('parser route test', () {
    test('should return the home path', () => runTest(homePath));

    test('shoudl return 404 path',
        () => runTest('/fakepath', toMatch: pageNotFoundPath));

    test('should return a static nested path', () => runTest(bookSettingsPath));

    test('shoudl return a dynamic static path with 1 param',
        () => runTest('/book/20', toMatch: bookDetailsPath));

    test('shoudl return a dynamic nested path',
        () => runTest('/dynamic/path/settings/branches', toMatch: userRepoSettingsBranches));
  });
}
