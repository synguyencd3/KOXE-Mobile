import 'package:flutter/material.dart';
import 'package:mobile/widgets/text_card.dart';

class Manage extends StatefulWidget {
  @override
  State<Manage> createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Quản lý'),
          backgroundColor: Colors.lightBlue,
        ),
        body: Column(
          children: [
            text_card(
                title: 'Quản lý gói',
                onTap: () {
                 Navigator.pushNamed(context, '/package/manage');
                }),
            text_card(
                title: 'Quản lý người dùng',
                onTap: () {
                  print('Tap');
                }),
            text_card(
                title: 'Quản lý đơn vị liên kết',
                onTap: () {
                  print('Tap');
                }),
            text_card(
                title: 'Quản lý xe',
                onTap: () {
                Navigator.pushNamed(context, '/listing/manage');
                }),
            text_card(
                title: 'Quản lý lịch hẹn',
                onTap: () {
                  print('Tap');
                }),
            text_card(
                title: 'Quản lý bảo hành',
                onTap: () {
                  print('Tap');
                }),
            text_card(
                title: 'Quản lý bảo dưỡng',
                onTap: () {
                  print('Tap');
                }),
            text_card(
                title: 'Quản lý kho',
                onTap: () {
                  print('Tap');
                }),
            text_card(
                title: 'Báo cáo doanh thu',
                onTap: () {
                  print('Tap');
                }),
          ],
        ));
  }
}
