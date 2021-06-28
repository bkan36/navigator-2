import 'dart:async';
import 'package:flutter/material.dart';
import 'package:navigator_2/routes/my_paths.dart';
import 'my_route_path.dart';

class MyRouterDelegate extends RouterDelegate<MyRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRoutePath> {
  factory MyRouterDelegate() => _singlton;
  static final MyRouterDelegate _singlton = MyRouterDelegate._();
  MyRouterDelegate._() : _navigatorKey = GlobalKey<NavigatorState>();

  List<MaterialPage> _pages = [];
  late List<MyRoutePath> appRoutePath = [];
  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  MyRoutePath? get currentConfiguration {
    print('GET CURRENT CONFIGURATION');
    return appRoutePath.last;
  }

  ValueChanged<MyRoutePath> get onTapped => _handleButtonTapped;

  void _handleButtonTapped(MyRoutePath appRoute) {
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

        if (appRoutePath.last.path == pageNotFoundPath) {
          appRoutePath.removeLast();
        }

        appRoutePath.removeLast();

        if (appRoutePath.length == 0)
          appRoutePath.add(MyRoutePath(path: {homePath: homePath}));

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
    _pages = [];
    
    // if (appRoutePath.length == 1) {
    // _buildPagesTree();
    // }

    // for (var arp in appRoutePath)
    //   _pages.add(
    //     MaterialPage(
    //       key: ValueKey(arp.path +
    //           (arp.params != null && arp.params!.isNotEmpty
    //               ? arp.params!.first!
    //               : '')),
    //       child: myRoutesMap[arp.path]!,
    //     ),
    //   );
  }

  _buildPagesTree() {
    final currentPath = appRoutePath.last.path.values.first;
    List<String> currentPathList = Uri.parse(currentPath).pathSegments;
    Map<int, String> pathMap = {};

    for (var path in myRoutesMap.keys) {
      List<String> pathSplited = Uri.parse(path).pathSegments;

      if (pathSplited.isNotEmpty && pathSplited[0] == currentPathList[0]) {
        var pathTmp = '';
        var i = 0;

        while (
            i < path.length && i < currentPath.length && path[i] == path[i]) {
          pathTmp += path[i];
          i++;
        }

        pathMap[path.length] = pathTmp;
      }
    }

    final List<String> pathSorted = pathMap.values.toList();
    pathSorted.sort((a, b) => a.length.compareTo(b.length));

    // for (var path in pathSorted) {}
  }
}
