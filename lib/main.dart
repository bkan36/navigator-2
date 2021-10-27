import 'package:flutter/material.dart';
import 'package:navigator_2/routes/my_route_information_parser.dart';
import 'package:navigator_2/routes/my_router_delegate.dart';

import 'package:url_strategy/url_strategy.dart';

final myRouteDelegate = MyRouterDelegate();
final myRouteInformationParser = MyRouteInformationParser();

void main() {
  setPathUrlStrategy();
  runApp(BooksApp());
}

class BooksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Books App',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
          colorScheme: ColorScheme(
            primary: Colors.green,
            primaryVariant: Colors.green[200]!,
            secondary: Colors.amber[50]!,
            secondaryVariant: Colors.amber[50]!,
            surface: Colors.blueGrey,
            background: Colors.blueGrey[900]!,
            error: Colors.red,
            onPrimary: Colors.green,
            onSecondary: Colors.amber[50]!,
            onSurface: Colors.blueGrey,
            onBackground: Colors.blueGrey[900]!,
            onError: Colors.redAccent,
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: Colors.blueGrey[900],
          textTheme: TextTheme(
            headline6: TextStyle(color: Colors.white),
            subtitle1: TextStyle(color: Colors.white),
            caption: TextStyle(color: Colors.white),
          )),
      routerDelegate: myRouteDelegate,
      routeInformationParser: myRouteInformationParser,
    );
  }
}
