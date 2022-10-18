import 'package:flutter/material.dart';
import 'package:mom_shop/app.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}
