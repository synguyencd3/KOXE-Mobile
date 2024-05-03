import 'package:flutter/material.dart';
import 'package:mobile/services/statistic_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../loading.dart';

// var dataMap = <String, dynamic>{
//   'Toyota Corolla': [12,2412043],
//   'Honda crv': [4,139111],
//   'name 1': [4, 22456]
// };

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final int y;
}


class Statistic extends StatefulWidget {
  @override
  State<Statistic> createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
  late Map<String, Map<String, dynamic>> invoicesMap= {};
  List<ChartData> chartData = [];
  DateTime time = DateTime.now().subtract(Duration(days: 30));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStat();
  }

  void getStat() async {
    var data = await StatisticService.getStatistic("${time.year}-${time.month}-${time.day}");
    print(data['maintenances']);
    setState(() {
      invoicesMap=data;
    });
    initChart();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: time,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != time) {
      setState(() {
        time = picked;
      });
      getStat();
    }
  }

  void initChart() {
    setState(() {
      chartData = invoicesMap['yearly']!.entries.map((e) => ChartData(int.parse(e.key), e.value)).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Invoices'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: GestureDetector(
                onTap: () => _selectDate(context),
                  child: Text('Từ ngày: ${time.day}/${time.month}/${time.year}')),
            ),
            Text('Bảo dưỡng'),
            invoicesMap.isEmpty ? Padding(
              padding: const EdgeInsets.all(30),
              child: Loading(),
            ) :
            Padding(
              padding: EdgeInsets.all(16.0),
              child:  DataTable(
                columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Car name',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Total invoices',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Total expenses',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
             rows: invoicesMap['maintenances']!.entries.map((e) => DataRow(
              cells: <DataCell>[
                DataCell(Text(e.key)),
                DataCell(Text('${e.value[0]}')),
                DataCell(Text('${e.value[1]}'))
              ]
             )
             ).toList(),),
            ),
            Text('Doanh số'),
            invoicesMap.isEmpty ? Padding(
              padding: const EdgeInsets.all(30),
              child: Loading(),
            ) :
            DataTable(
                columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Car name',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Total invoices',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Total expenses',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
             rows: invoicesMap['buyCars']!.entries.map( (e) => DataRow(
              cells: <DataCell>[
                DataCell(Text(e.key)),
                DataCell(Text('${e.value[0]}')),
                DataCell(Text('${e.value[1]}'))
              ]
             )
             ).toList(),),
            Text("Thống kê doanh thu"),
            SfCartesianChart(
              series: <CartesianSeries<ChartData,int>>[
                ColumnSeries(
                    dataSource: chartData,
                    xValueMapper: (ChartData data,_) => data.x,
                    yValueMapper: (ChartData data,_) => data.y
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
