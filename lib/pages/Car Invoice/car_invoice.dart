import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/pages/Car%20Invoice/Invoice_dialog.dart';
import 'package:mobile/pages/loading.dart';
import 'package:mobile/services/CarInvoice_Service.dart';
import 'package:mobile/services/salon_service.dart';

import '../../model/CarInvoice_response.dart';


class CarInvoiceList extends StatefulWidget {
  @override
  State<CarInvoiceList> createState() => _CarInvoiceListState();
}

class _CarInvoiceListState extends State<CarInvoiceList> {

  bool isLoading= false;
  List<CarInvoice> invoices = [];
  Set<String> permissions = {};
  void getInvoices() async {
    setState(() {
      isLoading = true;
    });
    var data = await CarInvoiceService.getAll(null);
    setState(() {
      invoices = data;
      isLoading = false;
    });
  }

  void callToRefresh() {
    getInvoices();
  }

  void getPermissions() async {
    var data = await SalonsService.getPermission();
    setState(() {
      permissions=data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInvoices();
    getPermissions();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giao dịch xe"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            permissions.contains("OWNER") || permissions.contains("C_IV") ?
             TextButton.icon(onPressed: () {
                Navigator.pushNamed(context, '/car_invoice/new').then((value) {
                  getInvoices();
                });
              }, label: Text("Thêm giao dịch"),
               icon: Icon(Icons.add),
            ) : Container(),
            (isLoading) ?  Loading():
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
                      return InvoiceDialog(model: invoice, callMethod: callToRefresh,);
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
                          Text('Tên khách hàng: ${invoice.fullname}'),
                          SizedBox(height: 5),
                          Text('Số điện thoại: ${invoice.phone}'),
                          SizedBox(height: 5),
                          Text('Biển số: ${invoice.licensePlate}'),
                          SizedBox(height: 5),
                          Text('Chi phí: ${invoice.expense}')
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

