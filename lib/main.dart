import 'package:flutter/material.dart';
import 'package:navigator_2/routes/my_route_information_parser.dart';
import 'package:navigator_2/routes/my_router_delegate.dart';

import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(BooksApp());
}

class BooksApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Books App',
      routerDelegate: MyRouterDelegate(),
      routeInformationParser: MyRouteInformationParser(),
    );
  }
}