import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/pages/Car%20Invoice/Invoice_dialog.dart';
import 'package:mobile/pages/Car%20Invoice/user_Invoice_dialog.dart';
import 'package:mobile/services/CarInvoice_Service.dart';

import '../../model/CarInvoice_response.dart';
import 'package:mobile/pages/loading.dart';
import 'package:mobile/utils/utils.dart';
class UserCarInvoiceList extends StatefulWidget {
  @override
  State<UserCarInvoiceList> createState() => _CarInvoiceListState();
}

class _CarInvoiceListState extends State<UserCarInvoiceList> {
  List<CarInvoice> invoices = [];

  Future<void> getInvoices() async {
    var data = await CarInvoiceService.getAllCustomer();
    invoices = data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lịch sử mua xe"),
      ),
      body: FutureBuilder(
          future: getInvoices(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }
            return invoices.isEmpty
                ? Center(child: Text('Không có lượt giao dịch nào'))
                : SingleChildScrollView(
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
                                  title: Text(invoice.carName!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: invoice.done == false
                                              ? Colors.red
                                              : Colors.green)),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Tên khách hàng: ${invoice.fullname}'),
                                      SizedBox(height: 5),
                                      Text('Số điện thoại: ${invoice.phone}'),
                                      SizedBox(height: 5),
                                      Text('Biển số: ${invoice.licensePlate ?? 'Chưa có'}'),
                                      SizedBox(height: 5),
                                      Text('Chi phí: ${formatCurrency(invoice.expense??0)}')
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
          }),
    );
  }
}
