import 'package:flutter/material.dart';
import 'package:mobile/pages/auth.dart';
import 'package:mobile/pages/login.dart';
import 'package:mobile/pages/news.dart';
import 'package:mobile/pages/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    //initialRoute: '/news',
    home: Auth(),
    routes: {
      '/login': (context) => LoginPage(),
      //'/register': (context) => Register(),
      '/news': (context) => NewsBoard()
    },
  ));
}
