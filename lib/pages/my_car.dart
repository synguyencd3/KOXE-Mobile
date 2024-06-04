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
        title: Text('Xe của tôi'),
      ),
      body: Column(
        children: <Widget>[
          text_card(
              title: 'Lịch sử mua xe',
              onTap: () {
                Navigator.pushNamed(context, '/customer/car_voice');
              }),
          text_card(
              title: 'Hóa đơn bảo dưỡng',
              onTap: () {
                Navigator.pushNamed(context, '/user_maintaince');
              }),
          text_card(
              title: 'Hóa đơn phụ tùng',
              onTap: () {
                Navigator.pushNamed(context,  '/user_accessory');
              }),

        ],
      ),
    );
  }
}
