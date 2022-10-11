import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mon_shop/home_page.dart';
import 'package:sizer/sizer.dart';

import 'routing/route_generator.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Steward',
        theme: ThemeData(
          fontFamily: GoogleFonts.kanit().fontFamily,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: generateRoute,
        initialRoute: HomePage.routeName,
      );
    });
  }
}
