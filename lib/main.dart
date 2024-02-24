import 'package:flutter/material.dart';
import 'package:mobile/login.dart';
import 'package:mobile/register.dart';



void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => Register()
      },
    )
  );
}

