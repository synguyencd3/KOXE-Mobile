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
        title: Text("Giao dịch xe"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(onPressed: () {
                Navigator.pushNamed(context, '/car_invoice/new').then((value) {
                  getInvoices();
                });
              }, child: Text("Thêm giao dịch"),),
            ),
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
                      title: Text(invoice.carName!,  style: TextStyle(
                          fontWeight:FontWeight.bold,fontSize: 20,
                          color: invoice.done== false? Colors.red: Colors.green
                      )),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Customer: ${invoice.fullname}'),
                          SizedBox(height: 5),
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

