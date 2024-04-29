import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/invoice_card.dart';

import '../model/invoice_model.dart';
import '../services/invoice_service.dart';
import 'package:mobile/pages/loading.dart';

class UserManage extends StatefulWidget {
  const UserManage({super.key});

  @override
  State<UserManage> createState() => _UserManageState();
}

class _UserManageState extends State<UserManage> {
  late List<InvoiceModel> invoices = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      await getAllInvoices();
    });
  }

  Future<void> getAllInvoices() async {
    List<InvoiceModel> invoicesAPI = await InvoiceService().getAllInvoices();
    setState(() {
      invoices = invoicesAPI;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lịch sử bảo dưỡng'),
        ),
        body: invoices.isEmpty
            ? Loading()
            : ListView.builder(
                itemCount: invoices.length,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return InvoiceCard(invoice: invoices[index]);
                }));
  }
}
