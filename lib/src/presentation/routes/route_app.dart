import 'package:base_flutter/src/presentation/routes/route_path.dart';
import 'package:base_flutter/src/presentation/screen/home/home_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class RouteApp {
  RouteApp();

  GoRouter get router => _router;

  final _rootNavigatorKey = GlobalKey<NavigatorState>();

  late final _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePath.initial,
    redirect: _guard,
    routes: [
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: RoutePath.initial,
        redirect: (_, __) => RoutePath.home,
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: HomeScreen.routeName,
        path: RoutePath.home,
        builder: (_, __) => const HomeScreen(),
      ),
    ],
  );

  Future<String?> _guard(BuildContext context, GoRouterState state) async {
    // add condition for redirect screen
    return null;
  }
}
