import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/pages/Car%20Invoice/Invoice_dialog.dart';
import 'package:mobile/services/CarInvoice_Service.dart';

import '../../model/CarInvoice_response.dart';


class CarInvoiceList extends StatefulWidget {
  @override
  State<CarInvoiceList> createState() => _CarInvoiceListState();
}

class _CarInvoiceListState extends State<CarInvoiceList> {
  // final List<Car> cars = [
  //   Car('Car 1', 'Customer 1', '1234567890'),
  //   Car('Car 2', 'Customer 2', '9876543210'),
  //   Car('Car 3', 'Customer 3', '5555555555'),
  // ];

  List<CarInvoice> invoices = [];

  void getInvoices() async {
    var data = await CarInvoiceService.getAll(null);
    setState(() {
      invoices = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInvoices();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Transaction'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextButton(onPressed: () {
              Navigator.pushNamed(context, '/car_invoice/new');
            }, child: Icon(CupertinoIcons.plus),),
            ListView.builder(
              shrinkWrap: true,
              itemCount: invoices.length,
              itemBuilder: (context, index) {
                final invoice = invoices[index];
                return GestureDetector(
                  onTap: () {
                    showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return InvoiceDialog(model: invoice);
                    });
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(invoice.carName!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Customer: ${invoice.fullname}'),
                          Text('Phone: ${invoice.phone}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Car {
  final String carName;
  final String customerName;
  final String phoneNumber;

  Car(this.carName, this.customerName, this.phoneNumber);
}