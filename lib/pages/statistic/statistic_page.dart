import 'package:flutter/material.dart';

var dataMap = <String, dynamic>{
  'Toyota Corolla': [12,2412043],
  'Honda crv': [4,139111],
  'name 1': [4, 22456]
};


class CarInvoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Invoices'),
      ),
      body: Column(
        children: [
          Text('Bảo dưỡng'),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: DataTable(
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
           rows: dataMap.entries.map( (e) => DataRow(
            cells: <DataCell>[
              DataCell(Text(e.key)),
              DataCell(Text('${e.value[0]}')),
              DataCell(Text('${e.value[1]}'))
            ]
           )
           ).toList(),),
          ),
          Text('Doanh số'),
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
           rows: dataMap.entries.map( (e) => DataRow(
            cells: <DataCell>[
              DataCell(Text(e.key)),
              DataCell(Text('${e.value[0]}')),
              DataCell(Text('${e.value[1]}'))
            ]
           )
           ).toList(),),        
        ],
      ),
    );
  }
}
