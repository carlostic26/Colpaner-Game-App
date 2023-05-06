import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigatorService {
  static final NavigatorService _instance = NavigatorService._internal();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  factory NavigatorService() {
    return _instance;
  }

  NavigatorService._internal();

  void init(BuildContext context) {
    navigatorKey = GlobalKey<NavigatorState>();
  }

  void navigateTo(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }
}
