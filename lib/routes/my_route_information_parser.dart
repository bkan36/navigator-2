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
      Map<String, String> params = {};

      for (var i = 0; i < routeUriList.length; i++)
        if (routeUriList[i][0] != PARAM_CHAR &&
            routeUriList[i] != pathUriList[i])
          diff++;
        else if (routeUriList[i][0] == PARAM_CHAR)
          params[routeUriList[i].replaceFirst(PARAM_CHAR, '')] = pathUriList[i];

      if (diff == 0) return MyRouteData(route, params: params);
    }
  }

  return MyRouteData(pageNotFoundPath);
}

String buildRouteLocation(MyRouteData route) {
  if (!route.path.contains(PARAM_CHAR)) return route.path;

  var location = '';
  final pathList = Uri.parse(route.path).pathSegments;

  for (var ps in pathList)
    if (ps[0] == PARAM_CHAR)
      location += '/${route.params[ps.replaceFirst(PARAM_CHAR, '')]!}';
    else
      location += '/$ps';

  return location;
}

class MyRouteInformationParser extends RouteInformationParser<MyRouteData> {
  @override
  Future<MyRouteData> parseRouteInformation(RouteInformation routeInf) async =>
      myRoutesParser(routeInf.location ?? '');

  @override
  RouteInformation? restoreRouteInformation(MyRouteData routePath) =>
      RouteInformation(location: buildRouteLocation(routePath));
}
