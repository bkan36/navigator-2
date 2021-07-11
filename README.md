# navigator_2

A way to implement navigator 2.0 without using a external package.

how to use ?

1 - Pass MyRouterDelegate() and MyRouteInformationParser() to your MaterialApp.router in main.dart:

    return MaterialApp.router(
      title: 'Books App',
      routerDelegate: MyRouterDelegate(),
      routeInformationParser: MyRouteInformationParser(),
    );

2 - Fill your routes in my_route_app.dart and be care to keep homePath, pageNotFoundPath and the
    PARAM_CHAR const, they are used in information_parser and router_delegate.
    each widget associated to a path don't have to take arguments in its constructor you'll retrieve them in a different way.

3 - To reach a route you just have to use this syntax:

    MyRouterDelegate()(MyRouteData(homePath, params: [book.id]))

    this will call the call method in my_router_delegate.dart, params is optional.

4 - To retrieve your data:
    var approute = MyRouterDelegate().currentConfiguration;
    Book? book = getBookById(approute!.params.first!);

    currentConfigaturation return MyRouteData that hold the current path and its params.

that's all.

to remove the # from url:
    - add this dependency in your pubspec.yaml file: url_strategy: ^0.2.0
    - before runApp(MyApp()) inside the main put setPathUrlStrategy(); and don't forget to import it