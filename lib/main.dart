import 'package:flutter/material.dart';
import 'package:mobile/login.dart';
import 'package:mobile/register.dart';
import 'package:mobile/pages/main_home.dart';
import 'package:mobile/widgets/introduction_car.dart';
import 'package:mobile/widgets/home.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    initialRoute: '/mhome',
    routes: {
      '/login': (context) => LoginPage(),
      '/register': (context) => Register(),
      '/mhome': (context) => MainHome(),
      '/car': (context) => IntroCar(),
      '/home': (context) => Home(),
    },
  ));
}
