import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/transaction_navigator_model.dart';
import 'package:mobile/services/statistic_service.dart';

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
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistic'),
      ),
      body: FutureBuilder(
          future: getStatistic(),
          builder: (context, snapshot) {
            return Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                      height: 200.0,
                      aspectRatio: 2.0,
                      enableInfiniteScroll: false,
                      autoPlay: true),
                  items: [
                    Card(
                      child: Center(
                        child: Text(transaction.totalAmount.toString()),
                      ),
                    )
                  ],
                ),
              ],
            );
          }),
    );
  }
}
