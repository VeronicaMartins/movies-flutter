import 'package:flutter/material.dart';
import 'core/constants.dart';
import 'core/theme_app.dart';
import 'pages/movie_page.dart';
import 'package:custom_splash/custom_splash.dart';

void main() {
  runApp(MaterialApp(
    home: CustomSplash(
      imagePath: 'lib/assets/iconInit.png',
      backGroundColor: Colors.grey,
      animationEffect: 'top-down',
      logoSize: 5000,
      home: MyApp(),
      duration: 2500,
      type: CustomSplashType.StaticDuration,
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: kThemeApp,
      home: MoviePage(),
    );
  }
}
