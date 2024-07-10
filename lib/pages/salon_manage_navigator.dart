
import 'package:flutter/material.dart';
import 'package:mobile/widgets/text_card.dart';

class SalonManageNavigator extends StatelessWidget {
  const SalonManageNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý hoa tiêu'),
      ),
      body: Column(
        children: [
          text_card(
              headingIcon: Icons.block,
              title: 'Quản lý hoa tiêu bị chặn',
              onTap: () {
                Navigator.pushNamed(context, '/blocked_user');
              }),
          text_card(
              headingIcon: Icons.post_add,
              title: 'Quản lý bài đăng kết nối',
              onTap: () {
                Navigator.pushNamed(context, '/post');
              }),
          text_card(
              headingIcon: Icons.connect_without_contact,
              title: 'Quản lý kết nối với hoa tiêu',
              onTap: () {
                Navigator.pushNamed(context, '/connection');
              }),
        ],
      )
    );
  }
}
