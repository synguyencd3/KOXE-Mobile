import 'package:flutter/material.dart';
import 'package:mobile/config.dart';
import 'package:mobile/services/cars_service.dart';
import 'package:mobile/widgets/text_card.dart';
import 'package:mobile/services/salon_service.dart';

import '../model/car_model.dart';
import 'package:mobile/services/payment_service.dart';
import 'package:mobile/pages/loading.dart';

class Manage extends StatefulWidget {
  @override
  State<Manage> createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  List<Car> cars = [];
  Set<String> permission = {};
  Set<String> keyMap = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getPermission();
      getKeyMap();
    });
  }

  Future<void> getPermission() async {
    var data = await SalonsService.getPermission();
    //setState(() {
      permission = data;
    //});
  }

  Future<void> getKeyMap() async {
    var data = await PaymentService.getKeySet();
    //setState(() {
      keyMap = data;
    //});
  }

  Future<void> callAPI() async {
    await getPermission();
    await getKeyMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Quản lý'),
          backgroundColor: Colors.lightBlue,
        ),
        body: FutureBuilder(
            future: callAPI(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loading();
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    text_card(
                        headingIcon: Icons.inventory,
                        title: 'Quản lý gói',
                        onTap: () {
                          Navigator.pushNamed(context, '/package/manage');
                        }),
                    keyMap.contains(Config.UserKeyMap) &&
                            (permission.contains("OWNER") ||
                                permission.contains("R_EMP"))
                        ? text_card(
                            headingIcon: Icons.person,
                            title: 'Quản lý nhân viên',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/employee_management');
                            })
                        : Container(),
                    permission.contains("OWNER")
                        ? text_card(
                            headingIcon: Icons.warning,
                            title: 'Quản lý quyền',
                            onTap: () {
                              Navigator.pushNamed(context, '/authorities');
                            })
                        : Container(),
                    text_card(
                        headingIcon: Icons.manage_accounts,
                        title: 'Quản lý hoa tiêu',
                        onTap: () {
                          Navigator.pushNamed(context, '/salon_manage_navigator');
                        }),
                    keyMap.contains(Config.CarKeyMap) &&
                            (permission.contains("OWNER") ||
                                permission.contains("R_CAR"))
                        ? text_card(
                            headingIcon: Icons.directions_car_filled,
                            title: 'Quản lý xe',
                            onTap: () {
                              Navigator.pushNamed(context, '/listing/manage');
                            })
                        : Container(),
                    keyMap.contains(Config.WarrantyKeyMap) &&
                            (permission.contains("OWNER") ||
                                permission.contains("R_WRT"))
                        ? text_card(
                            headingIcon: Icons.shield,
                            title: 'Quản lý bảo hành',
                            onTap: () {
                              Navigator.pushNamed(context, '/warranty_list');
                            })
                        : Container(),
                    keyMap.contains(Config.MaintainKeyMap) && permission.contains("OWNER") ||
                            permission.contains("R_MT")
                        ? text_card(
                            headingIcon: Icons.build,
                            title: 'Quản lý bảo dưỡng',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/maintaince_manage');
                            })
                        : Container(),
                    keyMap.contains(Config.AccessoryKeyMap)
                        ? text_card(
                            headingIcon: Icons.toys,
                            title: 'Quản lý phụ tùng',
                            onTap: () {
                              Navigator.pushNamed(context, '/accessory_manage');
                            })
                        : Container(),
                    permission.contains("OWNER") || permission.contains("R_IV")
                        ? text_card(
                            headingIcon: Icons.area_chart,
                            title: 'Báo cáo doanh thu',
                            onTap: () {
                              Navigator.pushNamed(context, '/statistic');
                            })
                        : Container(),
                    keyMap.contains(Config.ProcessKeyMap) ? text_card(
                        headingIcon: Icons.sync,
                        title: 'Quản lý qui trình',
                        onTap: () {
                          Navigator.pushNamed(context, '/process_list');
                        }): Container(),
                    keyMap.contains(Config.TransactionKeyMap) &&
                            (permission.contains("OWNER") ||
                                permission.contains("R_IV"))
                        ? text_card(
                            headingIcon: Icons.payment,
                            title: 'Quản lý giao dịch',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/transaction_manage');
                            })
                        : Container(),
                    keyMap.contains(Config.PromotionKeyMap) ? text_card(
                        headingIcon: Icons.discount,
                        title: 'Quản lý khuyến mãi',
                        onTap: () {
                          Navigator.pushNamed(context, '/salon_promotion');
                        }): Container(),
                  ],
                ),
              );
            }));
  }
}
