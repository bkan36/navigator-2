import 'package:flutter/material.dart';
import 'package:navigator_2/routes/my_route_information_parser.dart';
import 'dart:async';
import 'my_routes_app.dart';
import 'my_route_path.dart';

class MyRouterDelegate extends RouterDelegate<MyRouteData>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRouteData> {
  factory MyRouterDelegate() => _singlton;
  static final MyRouterDelegate _singlton = MyRouterDelegate._();
  MyRouterDelegate._() : _navigatorKey = GlobalKey<NavigatorState>() {
    _buildTrees();
  }

  final GlobalKey<NavigatorState> _navigatorKey;
  late MyRouteData routeData;

  List<MaterialPage> _pages = [];
  Map<String, List<MaterialPage>> routesPagesMap = {};
  Map<String, String> routePrevMap = {};

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  MyRouteData? get currentConfiguration => routeData;

  void call(MyRouteData appRoute) {
    routeData = appRoute;
    _buildPages(routeData);

    notifyListeners();
  }

  @override
  Widget build(BuildContext context) => Navigator(
        key: navigatorKey,
        pages: _pages.isEmpty
            ? [
                MaterialPage(
                  child: Center(
                    child: Text(
                      'Loading...',
                      style: TextStyle(
                        fontSize: 100,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ]
            : _pages,
        onPopPage: (route, result) {
          print('POPOPOP');
          if (!route.didPop(result)) return false;

          _onpop();

          notifyListeners();
          return true;
        },
      );

  @override
  Future<void> setNewRoutePath(MyRouteData route) async {
    routeData = route;
    return await _buildPages(route);
  }

  void _onpop() {
    var newPath = routePrevMap[routeData.path];

    List<String> pathList = Uri.parse(newPath!).pathSegments;

    var i = 0;
    var pathString = '';

    for (var a = 0; a < pathList.length; a++)
      if (pathList[a][0] == PARAM_CHAR) {
        pathString += '/${routeData.params[i]!}';
        i++;
      } else
        pathString += '/${pathList[a]}';

    routeData = myRoutesParser(pathString);
    _buildPages(routeData);
  }

  Future<void> _buildPages(MyRouteData appRoute) async =>
      _pages = routesPagesMap[appRoute.path]!;

  void _buildTrees() {
    final myRoutes = myRoutesMap.keys.toList();

    for (var route in myRoutes) {
      List<MaterialPage> pagesList = [];
      List<String> routeList = [];

      var uri = Uri.parse(route).pathSegments;
      var tmp = '';

      pagesList.add(MaterialPage(
        key: ValueKey(homePath),
        child: myRoutesMap[homePath]!,
      ));

      routeList.add(homePath);

      if (uri.isEmpty) tmp = homePath;

      for (var p in uri) {
        tmp += '/$p';

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
