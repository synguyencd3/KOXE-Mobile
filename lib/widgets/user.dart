import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/services/shared_service.dart';
import 'package:mobile/widgets/text_card.dart';
import 'package:mobile/services/api_service.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  Map<String, dynamic> userProfile = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfile();
  }

  Future<void> getUserProfile() async {
    try {
      Map<String, dynamic> profile = await APIService.getUserProfile();
      //print(profile);
      setState(() {
        userProfile = profile;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(userProfile['avatar'] != null
                ? userProfile['avatar']
                : 'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'),
          ),
        ),
        SizedBox(height: 10),
        Text(
          userProfile['fullname'] ?? '',
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
              // Navigator.pushReplacementNamed(context, '/login');
              SharedService.logout(context);
            }),
      ],
    );
  }
}
