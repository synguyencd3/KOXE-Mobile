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
  Set<String> permission = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getMySalon();
      getPermission();
    });
  }

  void getPermission() async {
    var data = await SalonsService.getPermission();
    setState(() {
      permission = data;
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
            permission.contains("OWNER") ?
            text_card(
                title: 'Quản lý người dùng',
                onTap: () {
                  Navigator.pushNamed(context, '/employee_management');
                }) : Container(),
            text_card(
                title: 'Quản lý hoa tiêu bị chặn',
                onTap: () {
                  Navigator.pushNamed(context, '/blocked_user');
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
            permission.contains("OWNER") || permission.contains("R_IV") ?
            text_card(
                title: 'Báo cáo doanh thu',
                onTap: () {
                  Navigator.pushNamed(context, '/statistic');
                }): Container(),
            text_card(
                title: 'Quản lý qui trình',
                onTap: () {
                  Navigator.pushNamed(context, '/process_list');
                }),
            permission.contains("OWNER") || permission.contains("R_IV") ?
            text_card(
                title: 'Quản lý giao dịch',
                onTap: () {
                  Navigator.pushNamed(context, '/car_voice');
                }): Container(),
            text_card(
                title: 'Lịch sử mua xe',
                onTap: () {
                  Navigator.pushNamed(context, '/customer/car_voice');
                }),
          ],
        ));
  }
}
