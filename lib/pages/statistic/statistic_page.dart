import 'package:flutter/material.dart';
import 'package:mobile/services/statistic_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:pie_chart/pie_chart.dart';

import '../loading.dart';


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
  Map<String, Map<String, dynamic>> invoicesMap= {};
  List<ChartData> chartData = [];
  DateTime time = DateTime.now();
  Map<String, dynamic> pieData ={};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStat();
  }

  void getStat() async {
    var data = await StatisticService.getStatistic("${time.year}-${time.month}-${time.day}");
    var topData = await StatisticService.getTop(time.year,time.month,time.day);
    print(topData);
    setState(() {
      invoicesMap=data;
      pieData = topData;
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
        title: Text('Báo cáo doanh thu'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: GestureDetector(
                onTap: () => _selectDate(context),
                  child: Text('Từ ngày: ${time.day}/${time.month}/${time.year}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
            ),
            Text('Bảo dưỡng',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
            invoicesMap.isEmpty ? Padding(
              padding: const EdgeInsets.all(30),
              child: Loading(),
            ) :
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                  child: DataTable(
                    columns: const <DataColumn>[
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Tên xe',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Số hóa đơn',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Tổng doanh thu',
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
            ),
            pieData.isEmpty ? SizedBox(height: 0) : Card(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PieChart(dataMap: pieData['MTTopDb']),
            )),
            Text('Doanh số',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
            invoicesMap.isEmpty ? Padding(
              padding: const EdgeInsets.all(30),
              child: Loading(),
            ) :
            Card(
              child: DataTable(
                  columns: const <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Tên xe',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Số hóa đơn',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Tổng doanh thu',
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
            ),
            pieData.isEmpty  ? SizedBox(height: 0,): Card(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PieChart(dataMap: pieData['buyCarTop']),
            )),
            Text("Thống kê doanh thu",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
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
