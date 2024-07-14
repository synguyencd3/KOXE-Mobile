import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/model/statistic_user_model.dart';
import 'package:mobile/services/statistic_service.dart';
import 'package:mobile/pages/loading.dart';
import 'package:mobile/widgets/total_card.dart';
import 'package:mobile/widgets/dropdown.dart';

class StatisticUser extends StatefulWidget {
  const StatisticUser({super.key});

  @override
  State<StatisticUser> createState() => _StatisticUserState();
}

class _StatisticUserState extends State<StatisticUser> {
  StatisticUserModel statisticUserModel = StatisticUserModel(
    totalExpense: 0,
    totalBuyCar: 0,
    totalAccessory: 0,
    totalMaintenance: 0,
  );
  String _selectedYear = 'Năm';
  String _selectedMonth ='Tháng';
  String _selectedQuarter = 'Quý';

  final List<String> _years = ['Năm','2021', '2022', '2023', '2024'];
  final List<String> _months = [
    'Tháng',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];
  final List<String> _quarters = ['Quý','1', '2', '3', '4'];

  Future<void> getStatistic() async {
    var response = await StatisticService.getTotalInvoice(_selectedYear,_selectedMonth , _selectedQuarter);
    //print('call');
    statisticUserModel = response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thống kê của bạn'),
      ),
      body: FutureBuilder(
          future: getStatistic(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownButton<String>(
                      value: _selectedYear,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedYear = newValue!;
                        });
                      },
                      items:
                          _years.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(width: 20),
                    DropdownButton<String>(
                      value: _selectedMonth,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedMonth = newValue!;
                        });
                      },
                      items:
                          _months.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(width: 20),
                    DropdownButton<String>(
                      value: _selectedQuarter,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedQuarter = newValue!;
                        });
                      },
                      items: _quarters
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Container(
                    height: 120,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TotalCard(
                        color: Colors.blueAccent,
                        label: 'Tổng chi phí',
                        total: statisticUserModel.totalExpense)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/customer/car_voice');
                  },
                  child: Container(
                      height: 120,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TotalCard(
                          color: Colors.yellowAccent,
                          label: 'Tổng chi phí mua xe',
                          total: statisticUserModel.totalBuyCar)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/user_accessory');
                  },
                  child: Container(
                      height: 120,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TotalCard(
                          color: Colors.greenAccent,
                          label: 'Tổng chi phí mua phụ kiện',
                          total: statisticUserModel.totalAccessory)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/user_maintaince');
                  },
                  child: Container(
                      height: 120,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TotalCard(
                          color: Colors.redAccent,
                          label: 'Tổng chi phí bảo dưỡng',
                          total: statisticUserModel.totalMaintenance)),
                ),
              ],
            );
          }),
    );
  }
}
