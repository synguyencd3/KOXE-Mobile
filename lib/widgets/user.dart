import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        ListTile(
          title: Text('Thông tin cá nhân'),
          trailing: Icon(Icons.account_circle),
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          title: Text('Mời bạn bè'),
          trailing: Icon(Icons.person_add),
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          title: Text('Đăng xuất'),
          trailing: Icon(Icons.logout),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }
}
