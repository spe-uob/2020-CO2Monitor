import 'package:co2_monitor/pages/criticalList.dart';
import 'package:co2_monitor/pages/debug.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';
import '../utils.dart';

/// This class manages navigation via static routes.
class NavigationProvider {
  /// Singleton instance.
  static final NavigationProvider _instance = NavigationProvider._internal();
  factory NavigationProvider() => _instance;
  NavigationProvider._internal();

  /// Predefined dictionary of routes. To navigate to a new page, a new route
  /// with a sensible name should be added here.
  final Map<String, Widget Function(BuildContext)> routes = {
    "/": (context) => MainView(),
    "/critical": (context) => wrapRoute(CriticalList()),
    "/debug": (context) => wrapRoute(Debug()),
  };
  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  /// Navigate to a given predefined page from anywhere in the app.
  Future navigateTo(String route) => navKey.currentState.pushNamed(route);
}
