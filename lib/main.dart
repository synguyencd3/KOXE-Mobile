import 'package:flutter/material.dart';
import 'package:mobile/pages/cars_listing.dart';
import 'package:mobile/pages/login.dart';
import 'package:mobile/pages/news.dart';
import 'package:mobile/pages/register.dart';
import 'package:mobile/pages/main_home.dart';
import 'package:mobile/widgets/introduction_car.dart';
import 'package:mobile/pages/manage.dart';
import 'package:mobile/pages/message.dart';
import 'package:mobile/pages/notification.dart';
import 'package:mobile/pages/user_info.dart';
import 'package:mobile/pages/appointment.dart';
import 'package:mobile/pages/car_detail.dart';
import 'package:mobile/pages/buy_package.dart';
import 'package:mobile/pages/all_packages.dart';
import 'package:mobile/pages/link_social.dart';
import 'package:mobile/pages/setting.dart';
import 'package:mobile/pages/manage_package.dart';
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
      '/news': (context) => NewsBoard(),
      '/listing/manage': (context) => CarsListing(),
      '/listing': (context) => IntroCar(),
      '/manage': (context) => Manage(),
      '/message': (context) => Message(),
      '/notification': (context) => Noti(),
      '/user_info': (context) => UserInfo(),
      '/appointment': (context) => Appointment(),
      '/car_detail': (context) => CarDetail(),
      '/buy_package': (context) => BuyPackage(),
      '/packages': (context) => AllPackages(),
      'social': (context) => Social(),
      '/setting': (context) => Setting(),
      '/package/manage': (context) => ManagePackage(),
    },
  ));
}
