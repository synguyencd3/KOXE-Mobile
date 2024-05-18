import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/pages/Car%20Invoice/Invoice_dialog.dart';
import 'package:mobile/pages/Car%20Invoice/user_Invoice_dialog.dart';
import 'package:mobile/services/CarInvoice_Service.dart';

import '../../model/CarInvoice_response.dart';


class UserCarInvoiceList extends StatefulWidget {
  @override
  State<UserCarInvoiceList> createState() => _CarInvoiceListState();
}

class _CarInvoiceListState extends State<UserCarInvoiceList> {


  List<CarInvoice> invoices = [];

  void getInvoices() async {
    var data = await CarInvoiceService.getAllCustomer();
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
        title: Text("Lịch sử mua xe"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                          return UserInvoiceDialog(model: invoice);
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
