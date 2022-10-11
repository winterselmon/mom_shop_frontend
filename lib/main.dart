import 'package:flutter/material.dart';
import 'package:mon_shop/app.dart';
import 'package:url_strategy/url_strategy.dart';


void main() {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}
