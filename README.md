# navigator_2

A way to implement navigator 2.0 without using a external package.

how to use ?

1 - copy routes folder in your project.

2 - Pass MyRouterDelegate() and MyRouteInformationParser() to your MaterialApp.router in main.dart:

    return MaterialApp.router(
      title: 'Books App',
      ...
      ...
      routerDelegate: MyRouterDelegate(),
      routeInformationParser: MyRouteInformationParser(),
    );

3 - Fill your routes in my_route_app.dart and be care to keep homePath, pageNotFoundPath and the
    PARAM_CHAR const, they are used in information_parser and router_delegate.
    Each widget associated to a path don't have to take arguments in its constructor
    you'll retrieve them in a different way.

4 - To reach a route you just have to use this syntax:

    MyRouterDelegate()(MyRouteData(homePath, params: {'id': book.id}))

    this will call the call method in my_router_delegate.dart, params is optional.

5 - To retrieve your params:

    var approute = MyRouterDelegate().currentConfiguration;
    Book? book = getBookById(approute!.params['id']!);

    currentConfigaturation return MyRouteData that hold the current path and its params.
    'id' must be the same name defined in myRouteMap (my_routes_app.dart).

that's all.

to remove the # from url:
    - add this dependency in your pubspec.yaml file -> url_strategy: ^0.2.0
    - before runApp(MyApp()) inside the main put setPathUrlStrategy(); and don't forget to import it


!!! WARNING !!!

    If your app have 2 routes like bookDetailsPath and userRepo (my_routes_app.dart)
    be care of "book" keyword because if someone has book as name it will result in unintended behavior
    he will be redirect to /book/:id instead of /:user/:repo.