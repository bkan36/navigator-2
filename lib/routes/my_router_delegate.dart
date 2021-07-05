import 'dart:async';
import 'package:flutter/material.dart';
import 'package:navigator_2/routes/my_routes_app.dart';
import 'my_route_path.dart';

class MyRouterDelegate extends RouterDelegate<MyRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRoutePath> {
  factory MyRouterDelegate() => _singlton;
  static final MyRouterDelegate _singlton = MyRouterDelegate._();
  MyRouterDelegate._() : _navigatorKey = GlobalKey<NavigatorState>() {
    _buildPagesTree();
  }

  final GlobalKey<NavigatorState> _navigatorKey;
  late List<MyRoutePath> appRoutePath = [];

  List<MaterialPage> _pages = [];
  Map<String, List<MaterialPage>> pathPagesMap = {};

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  MyRoutePath? get currentConfiguration {
    print('GET CURRENT CONFIGURATION');
    return appRoutePath.last;
  }

  void call(MyRoutePath appRoute) {
    appRoutePath.add(appRoute);
    _buildPages(appRoutePath.last);

    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    print('BUILD WIDGET (NAVIGATOR)');
    return Navigator(
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
        print('ON POP PAGE');
        if (!route.didPop(result)) return false;

        appRoutePath.removeLast();

        if (appRoutePath.length == 0) appRoutePath.add(MyRoutePath(homePath));

        _buildPages(appRoutePath.last);

        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(MyRoutePath route) async {
    print('SET NEW ROUTE PATH');
    appRoutePath.add(route);
    return await _buildPages(route);
  }

  Future<void> _buildPages(MyRoutePath appRoute) async {
    print('BUILD PAGES');
    print(appRoute);

    _pages = pathPagesMap[appRoute.path]!;

  }

  void _buildPagesTree() {
    final routeSorted = myRoutesMap.keys.toList();
    routeSorted.sort((a, b) => b.length.compareTo(a.length));

    for (var route in routeSorted) {
      List<MaterialPage> pagesList = [];
      var uri = Uri.parse(route).pathSegments;
      var tmp = '';

      pagesList.add(MaterialPage(
        key: ValueKey(homePath),
        child: myRoutesMap[homePath]!,
      ));

      if (uri.isEmpty) tmp = '/';

      for (var p in uri) {
        tmp += '/$p';

        for (var i = 0; i < routeSorted.length; i++)
          if (routeSorted[i] == tmp) {
            pagesList.add(MaterialPage(
              key: ValueKey(routeSorted[i] + i.toString()),
              child: myRoutesMap[tmp]!,
            ));
            break;
          }
      }
      pathPagesMap[tmp] = pagesList;
    }
  }
}
