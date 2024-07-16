import 'package:flutter/material.dart';
import 'package:mobile/widgets/text_card.dart';

class MyCar extends StatefulWidget {
  const MyCar({super.key});

  @override
  State<MyCar> createState() => _MyCarState();
}

class _MyCarState extends State<MyCar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý cá nhân'),
      ),
      body: Column(
        children: <Widget>[
          text_card(
            headingIcon: Icons.history,
              title: 'Lịch sử mua xe',
              onTap: () {
                Navigator.pushNamed(context, '/customer/car_voice');
              }),
          text_card(
            headingIcon: Icons.receipt,
              title: 'Hóa đơn bảo dưỡng',
              onTap: () {
                Navigator.pushNamed(context, '/user_maintaince');
              }),
          text_card(
            headingIcon: Icons.receipt,
              title: 'Hóa đơn phụ tùng',
              onTap: () {
                Navigator.pushNamed(context,  '/user_accessory');
              }),
          text_card(
              headingIcon: Icons.car_crash,
              title: 'Xe của tôi',
              onTap: () {
                Navigator.pushNamed(context,  '/car_customer');
              }),
          text_card(
              headingIcon: Icons.area_chart,
              title: 'Thống kê của bạn',
              onTap: () {
                Navigator.pushNamed(context, '/statistic_user');
              }),

        ],
      ),
    );
  }
}
