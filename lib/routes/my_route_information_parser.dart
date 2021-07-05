import 'package:flutter/material.dart';

import 'my_routes_app.dart';
import 'my_route_path.dart';

// MyRoutePath checkParams(String route, String pathFromUrl) {
//   if (route.endsWith(PARAM_CHAR) == false)
//     return MyRoutePath(route, dynamicPath: pathFromUrl);

//   final routeList = Uri.parse(route).pathSegments;
//   final pathList = Uri.parse(pathFromUrl).pathSegments;

//   List<String> params = [];

//   for (var i = 0; i < routeList.length; i++)
//     if (routeList[i] == PARAM_CHAR) params.add(pathList[i]);

//   return MyRoutePath(route, dynamicPath: pathFromUrl, params: params);
// }

MyRoutePath myRoutesParser(String pathFromUrl) {
  final List<String> pathUriList = Uri.parse(pathFromUrl).pathSegments;

  if (pathUriList.isEmpty) return MyRoutePath(homePath);

  for (var route in myRoutesMap.keys) {
    List<String> routeUriList = Uri.parse(route).pathSegments;

    if (routeUriList.length == pathUriList.length) {
      var diff = 0;
      List<String> params = [];

      for (var i = 0; i < routeUriList.length; i++)
        if (routeUriList[i][0] != PARAM_CHAR &&
            routeUriList[i] != pathUriList[i])
          diff++;
        else if (routeUriList[i][0] == PARAM_CHAR) params.add(pathUriList[i]);

      if (diff == 0)
        return MyRoutePath(route, dynamicPath: pathFromUrl, params: params);
    }
  }

  return MyRoutePath(pageNotFoundPath);
}

String buildRouteLocation(MyRoutePath route) {
  if (route.dynamicPath.isNotEmpty) return route.dynamicPath;
  if (!route.path.contains(PARAM_CHAR)) return route.path;

  var i = 0;
  var location = '';
  final pathList = Uri.parse(route.path).pathSegments;
  for (var ps in pathList)
    if (ps[0] == PARAM_CHAR) {
      location += '/${route.params[i]!}';
      i++;
    } else
      location += '/$ps';

  return location;
}

class MyRouteInformationParser extends RouteInformationParser<MyRoutePath> {
  @override
  Future<MyRoutePath> parseRouteInformation(RouteInformation routeInf) async {
    print('PARSE ROUTE INFORMATION');
    return myRoutesParser(routeInf.location ?? '');
  }

  @override
  RouteInformation? restoreRouteInformation(MyRoutePath routePath) {
    print('RESTORE ROUTE INFORMATION');

    return RouteInformation(location: buildRouteLocation(routePath));
  }
}

// Future<MyRoutePath> myRouteParserAsync(String? path) async {
//   final List<String> urlFetchedList = Uri.parse(path ?? '').pathSegments;

//   if (urlFetchedList.length == 0 || path == '/')
//     return MyRoutePath(homePath);

//   final routes = myRoutesMap.keys.toList();
//   Map<int, String> pathMap = {};
//   var similarity = 0;
//   var tmp;

//   for (var pathsApp in routes) {
//     List<String> pathSplited = Uri.parse(pathsApp).pathSegments;

//     if (pathSplited.isNotEmpty && pathSplited.first == urlFetchedList.first) {
//       var pathTmp = '';
//       var i = 0;

//       while (
//           i < pathsApp.length && i < path!.length && pathsApp[i] == path[i]) {
//         pathTmp += pathsApp[i];
//         i++;
//       }

//       if (tmp == pathTmp) similarity++;

//       pathMap[pathsApp.length] = pathTmp;
//       tmp = pathTmp;
//     }
//   }

//   if (pathMap.keys.length > 0 || similarity > 1) {
//     var finalPath = pathMap.values.first;

//     if (finalPath == path) return MyRoutePath(path!);

//     var a = 0;

//     for (var p in pathMap.keys) if (p > a) a = p;

//     final paramRouteList = Uri.parse(path!.substring(a)).pathSegments;
//     finalPath = path.substring(0, a);

//     return MyRoutePath(finalPath, params: paramRouteList);
//   }

//   return MyRoutePath(pageNotFoundPath);
// }
