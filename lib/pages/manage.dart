import 'package:flutter/material.dart';
import 'package:mobile/widgets/text_card.dart';
import 'package:mobile/services/salon_service.dart';

import '../model/car_model.dart';

class Manage extends StatefulWidget {
  @override
  State<Manage> createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  List<Car> cars = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getMySalon();
    });
  }

  void getMySalon() async {
    var salon = await SalonsService.getMySalon();
    //print(salon!.cars?[0].description);
    setState(() {
      cars = salon!.cars!;
    });
  }
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
                  Navigator.pushNamed(context, '/employee_management');
                }),
            text_card(
                title: 'Quản lý đơn vị liên kết',
                onTap: () {
                  print('Tap');
                }),
            text_card(
                title: 'Quản lý xe',
                onTap: () {
                Navigator.pushNamed(context, '/listing/manage',arguments: cars);
                }),
            text_card(
                title: 'Quản lý bảo hành',
                onTap: () {
                  Navigator.pushNamed(context, '/warranty_list');
                }),
            text_card(
                title: 'Quản lý bảo dưỡng',
                onTap: () {
                  Navigator.pushNamed(context, '/maintaince_manage');
                }),
            text_card(
                title: 'Quản lý phụ tùng',
                onTap: () {
                 Navigator.pushNamed(context, '/accessory_manage');
                }),
            text_card(
                title: 'Báo cáo doanh thu',
                onTap: () {
                  Navigator.pushNamed(context, '/statistic');
                }),
            text_card(
                title: 'Quản lý qui trình',
                onTap: () {
                  Navigator.pushNamed(context, '/process_list');
                }),
          ],
        ));
  }
}
