import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
            backgroundImage: AssetImage('assets/1.png'),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                print('Facebook');
              },
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Facebook_f_logo_%282019%29.svg/640px-Facebook_f_logo_%282019%29.svg.png',
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                print('Google');
              },
              child: Image.network(
                'data:image/png;base64,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',
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        text_card(
            title: 'Thông tin cá nhân',
            icon: Icons.person,
            onTap: () {
              print('Tap');
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
              print('Tap');
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
              Navigator.pushReplacementNamed(context, '/login');
            }),
      ],
    );
  }
}
