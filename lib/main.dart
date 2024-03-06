import 'package:flutter/material.dart';
import 'package:mobile/pages/auth.dart';
import 'package:mobile/pages/login.dart';
import 'package:mobile/pages/news.dart';
import 'package:mobile/pages/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:mobile/pages/cars_listing.dart';
import 'package:mobile/pages/login.dart';
import 'package:mobile/pages/news.dart';
import 'package:mobile/pages/register.dart';
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
    initialRoute: '/login',
    routes: {
      '/login': (context) => LoginPage(),
      '/register': (context) => Register(),
      '/mhome': (context) => MainHome(),
      '/news': (context) => NewsBoard(),
      '/listing/manage': (context) => CarsListing(),
      '/listing': (context) => IntroCar(),
    },
  ));
}
