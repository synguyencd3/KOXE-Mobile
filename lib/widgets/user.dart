import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/services/shared_service.dart';
import 'package:mobile/widgets/text_card.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/2.jpg'),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Username',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        text_card(
            title: 'Thông tin cá nhân',
            icon: Icons.person,
            onTap: () {
             Navigator.pushNamed(context, '/user_info');
            }),
        text_card(
            title: 'Mời bạn bè',
            icon: Icons.person_add,
            onTap: () {
              print('Tap');
            }),
        text_card(
            title: 'Cài đặt',
            icon: Icons.settings,
            onTap: () {
             Navigator.pushNamed(context, '/setting');
            }),
        text_card(
            title: 'Quản lý',
            icon: Icons.manage_accounts,
            onTap: () {
              Navigator.pushNamed(context, '/manage');
            }),
        text_card(
            title: 'Đăng xuất',
            icon: Icons.logout,
            onTap: () {
              SharedService.logout(context);
              //Navigator.pushReplacementNamed(context, '/login');
            }),
      ],
    );
  }
}
