import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/transaction_navigator_model.dart';
import 'package:mobile/services/statistic_service.dart';
import 'package:mobile/widgets/total_card.dart';
import 'package:mobile/pages//loading.dart';

class StatisticNavigator extends StatefulWidget {
  const StatisticNavigator({super.key});

  @override
  State<StatisticNavigator> createState() => _StatisticNavigatorState();
}

class _StatisticNavigatorState extends State<StatisticNavigator> {
  TransactionNavigatorModel transaction = TransactionNavigatorModel(
      navigators: [], totalAmount: 0, totalComplete: 0);

  Future<void> getStatistic() async {
    var data = await StatisticService.totalNavigator();
    transaction = data;
    print(transaction.totalAmount);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thống kê hoa tiêu'),
      ),
      body: FutureBuilder(
          future: getStatistic(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }
            return Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                      height: 150.0,
                      aspectRatio: 2.0,
                      enableInfiniteScroll: false,
                      autoPlay: true),
                  items: [
                    TotalCard(
                      label: 'Tổng tiền nhận được',
                      total: transaction.totalAmount,
                    ),
                    Card(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              transaction.totalComplete.toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text('Tổng số giao dịch hoàn thành')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'STT',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Tên',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Số điện thoại',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: transaction.navigators
                        .asMap()
                        .entries
                        .map((e) => DataRow(cells: [
                              DataCell(Text((e.key + 1).toString())),
                              // e.key is the index
                              DataCell(Text(e.value.name)),
                              DataCell(Text(e.value.phone)),
                            ]))
                        .toList(),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
