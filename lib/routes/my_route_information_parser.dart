import 'package:flutter/material.dart';

import 'my_routes_app.dart';
import 'my_route_data.dart';

MyRouteData myRoutesParser(String pathFromUrl) {
  final List<String> pathUriList = Uri.parse(pathFromUrl).pathSegments;

  if (pathUriList.isEmpty) return MyRouteData(homePath);

  for (var route in myRoutesMap.keys) {
    List<String> routeUriList = Uri.parse(route).pathSegments;

    if (routeUriList.length == pathUriList.length) {
      var diff = 0;
      Map<String, dynamic> params = {};

      for (var i = 0; i < routeUriList.length; i++)
        if (routeUriList[i][0] != paramChar &&
            routeUriList[i] != pathUriList[i])
          diff++;
        else if (routeUriList[i][0] == paramChar)
          params[routeUriList[i].replaceFirst(paramChar, '')] = pathUriList[i];

      if (diff == 0) return MyRouteData(route, params: params);
    }
  }

  return MyRouteData(pageNotFoundPath);
}

String buildRouteLocation(MyRouteData route) {
  if (!route.path.contains(paramChar)) return route.path;

  var location = '';
  final pathList = Uri.parse(route.path).pathSegments;

  for (var ps in pathList)
    if (ps[0] == paramChar)
      location += '/${route.params[ps.replaceFirst(paramChar, '')].toString()}';
    else
      location += '/$ps';

  return location;
}

class MyRouteInformationParser extends RouteInformationParser<MyRouteData> {
  @override
  Future<MyRouteData> parseRouteInformation(
          RouteInformation routeInformation) async =>
      myRoutesParser(routeInformation.location ?? '');

  @override
  RouteInformation? restoreRouteInformation(MyRouteData configuration) =>
      RouteInformation(location: buildRouteLocation(configuration));
}
