import 'package:flutter/material.dart';
import 'my_route_information_parser.dart';
import 'dart:async';
import 'my_routes_app.dart';
import 'my_route_data.dart';

final routeController = MyRouterDelegate();

class MyRouterDelegate extends RouterDelegate<MyRouteData>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRouteData> {
  factory MyRouterDelegate() => _singlton;
  static final MyRouterDelegate _singlton = MyRouterDelegate._();
  MyRouterDelegate._() : _navigatorKey = GlobalKey<NavigatorState>() {
    _buildListPages();
  }

  final GlobalKey<NavigatorState> _navigatorKey;
  MyRouteData routeData = MyRouteData(homePath);

  List<MaterialPage> _pages = [];
  Map<String, List<MaterialPage>> routesPagesMap = {};
  Map<String, String> routePrevMap = {};

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  MyRouteData? get currentConfiguration => routeData;

  void call(MyRouteData appRoute) {
    routeData = appRoute;
    _pages = routesPagesMap[appRoute.path]!;

    notifyListeners();
  }

  @override
  Widget build(BuildContext context) => Navigator(
        key: navigatorKey,
        pages: _pages.isEmpty
            ? [MaterialPage(child: Container(color: Colors.blueGrey[900]))]
            : _pages,
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;

          _onpop();

          notifyListeners();
          return true;
        },
      );

  @override
  Future<void> setNewRoutePath(MyRouteData appRoute) async {
    routeData = appRoute;
    _pages = routesPagesMap[appRoute.path]!;
  }

  void _onpop() {
    var newPath = routePrevMap[routeData.path];

    List<String> pathList = Uri.parse(newPath!).pathSegments;

    var pathString = '';

    for (var ps in pathList)
      if (ps[0] == paramChar)
        pathString += '/${routeData.params[ps.replaceFirst(paramChar, '')]!}';
      else
        pathString += '/$ps';

    routeData = myRoutesParser(Uri.parse(pathString));
    _pages = routesPagesMap[routeData.path]!;
  }

  void _buildListPages() {
    final myRoutes = myRoutesMap.keys.toList();

    for (var route in myRoutes) {
      List<MaterialPage> pagesList = [];
      List<String> routeList = [];

      var uri = Uri.parse(route).pathSegments;
      var tmp = '';

      pagesList.add(MaterialPage(
        key: const ValueKey(homePath),
        child: myRoutesMap[homePath]!,
      ));

      routeList.add(homePath);

      if (route == homePath)
        tmp = homePath;
      else
        for (var ps in uri) {
          tmp += '/$ps';

          for (var i = 0; i < myRoutes.length; i++)
            if (myRoutes[i] == tmp) {
              pagesList.add(MaterialPage(
                key: ValueKey(myRoutes[i] + i.toString()),
                child: myRoutesMap[tmp]!,
              ));
              routeList.add(tmp);
              break;
            }
        }

      if (tmp != homePath) routeList.removeLast();

      routePrevMap[tmp] = routeList.last;
      routesPagesMap[tmp] = pagesList;
    }
  }
}
