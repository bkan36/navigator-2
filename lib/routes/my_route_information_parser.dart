import 'package:flutter/material.dart';
import 'package:navigator_2/routes/my_paths.dart';

import 'my_route_path.dart';

const DYNAMIC_CHAR = '*';

class MyRouteInformationParser extends RouteInformationParser<MyRoutePath> {
  @override
  Future<MyRoutePath> parseRouteInformation(RouteInformation routeInf) async {
    print('PARSE ROUTE INFORMATION');
    return myRoutesParser(routeInf.location ?? '');
  }

  @override
  RouteInformation? restoreRouteInformation(MyRoutePath routePath) {
    print('RESTORE ROUTE INFORMATION');
    var location = routePath.path.keys.first;

    // if (routePath.params != null) {
    //   if (location.lastIndexOf('/') == location.length - 1)
    //     location =
    //         location.replaceRange(location.length - 1, location.length, '');
    //   routePath.params!.forEach((param) => location += '/$param');
    // }

    return RouteInformation(location: location);
  }
}

// Future<MyRoutePath> myRouteParserAsync(String? path) async {
//   final List<String> urlFetchedList = Uri.parse(path ?? '').pathSegments;

//   if (urlFetchedList.length == 0 || path == '/')
//     return MyRoutePath(path: homePath);

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

//     if (finalPath == path) return MyRoutePath(path: path!);

//     var a = 0;

//     for (var p in pathMap.keys) if (p > a) a = p;

//     final paramRouteList = Uri.parse(path!.substring(a)).pathSegments;
//     finalPath = path.substring(0, a);

//     return MyRoutePath(path: finalPath, params: paramRouteList);
//   }

//   return MyRoutePath(path: pageNotFoundPath);
// }

MyRoutePath myRoutesParser(String pathFromUrl) {
  final List<String> pathUriList = Uri.parse(pathFromUrl).pathSegments;

  if (pathUriList.isEmpty) return MyRoutePath(path: {homePath: homePath});

  for (var route in myRoutesMap.keys) {
    List<String> routeUriList = Uri.parse(route).pathSegments;

    if (routeUriList.length == pathUriList.length) {
      var diff = 0;
      
      for (var i = 0; i < routeUriList.length; i++)
        if (routeUriList[i] != DYNAMIC_CHAR && routeUriList[i] != pathUriList[i]) diff++;

      if (diff == 0) return MyRoutePath(path: {pathFromUrl: route});
    }
  }

  return MyRoutePath(path: {pageNotFoundPath: pageNotFoundPath});
}
