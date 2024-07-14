import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/invoice_card.dart';

import '../../model/invoice_model.dart';
import '../../services/invoice_service.dart';
import 'package:mobile/pages/loading.dart';

class UserMaintaince extends StatefulWidget {
  const UserMaintaince({super.key});

  @override
  State<UserMaintaince> createState() => _UserMaintainceState();
}

class _UserMaintainceState extends State<UserMaintaince> {
  late List<InvoiceModel> invoices = [];

  Future<void> getAllInvoices() async {
    List<InvoiceModel>? data = ModalRoute.of(context)!.settings.arguments as List<InvoiceModel>?;
    if (data != null) {
      print('data is not null');
    } else {
      List<InvoiceModel> invoicesAPI = await InvoiceService().getAllInvoices();
      invoices = invoicesAPI;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lịch sử bảo dưỡng'),
        ),
        body: FutureBuilder(
            future: getAllInvoices(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loading();
              }
              return ListView.builder(
                  itemCount: invoices.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InvoiceCard(invoice: invoices[index]);
                  });
            }));
  }
}
