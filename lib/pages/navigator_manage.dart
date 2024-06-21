
import 'package:flutter/material.dart';

import '../widgets/text_card.dart';

class NavigatorManage extends StatelessWidget {
  const NavigatorManage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý hoa tiêu'),
      ),
      body: Column(
        children: [
          text_card(
            headingIcon: Icons.payment,
              title: 'Quản lý giao dịch với salon',
              onTap: () {
                Navigator.pushNamed(context, '/transaction');
              }),
          text_card(
            headingIcon: Icons.post_add,
              title: 'Tạo bài kết nối với salon',
              onTap: () {
                Navigator.pushNamed(context, '/create_post');
              }),
          text_card(
            headingIcon: Icons.connect_without_contact,
              title: 'Quản lý kết nối với salon',
              onTap: () {
                Navigator.pushNamed(context, '/connection');
              }),
          text_card(
            headingIcon: Icons.group,
              title: 'Quản lý group salon',
              onTap: () {
                Navigator.pushNamed(context, '/salon_group');
              }),
        ],
      ),
    );
  }
}
