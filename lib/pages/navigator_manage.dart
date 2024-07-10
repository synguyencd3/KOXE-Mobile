
import 'package:flutter/material.dart';
import 'package:mobile/config.dart';

import '../widgets/text_card.dart';
import 'package:mobile/services/payment_service.dart';
class NavigatorManage extends StatefulWidget {
  const NavigatorManage({super.key});

  @override
  State<NavigatorManage> createState() => _NavigatorManageState();
}

class _NavigatorManageState extends State<NavigatorManage> {
  Set<String> keyMap = {};
  Future<void> getKeyMap() async {
    var data = await PaymentService.getKeySet();
    //setState(() {
    keyMap = data;
    //});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý hoa tiêu'),
      ),
      body: Column(
        children: [
          text_card(
              headingIcon: Icons.inventory,
              title: 'Gói đang sử dụng',
              onTap: () {
                Navigator.pushNamed(context, '/package/manage');
              }),
          keyMap.contains(Config.TransactionNavigatorKeyMap) ? text_card(
            headingIcon: Icons.payment,
              title: 'Quản lý giao dịch với salon',
              onTap: () {
                Navigator.pushNamed(context, '/transaction');
              }) : Container(),
          keyMap.contains(Config.CreatePostKeyMap) ? text_card(
            headingIcon: Icons.post_add,
              title: 'Tạo bài kết nối với salon',
              onTap: () {
                Navigator.pushNamed(context, '/create_post');
              }): Container(),
          keyMap.contains(Config.ConnectionKeyMap) ? text_card(
            headingIcon: Icons.connect_without_contact,
              title: 'Quản lý kết nối với salon',
              onTap: () {
                Navigator.pushNamed(context, '/connection');
              }) : Container(),
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
