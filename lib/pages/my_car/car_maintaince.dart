import 'package:flutter/material.dart';
import 'package:mobile/services/invoice_service.dart';
import 'package:mobile/widgets/invoice_card.dart';

class CarMaintaince extends StatefulWidget {
  const CarMaintaince({super.key});

  @override
  State<CarMaintaince> createState() => _CarMaintainceState();
}

class _CarMaintainceState extends State<CarMaintaince> {
  List invoices = [];

  Future<void> getMaintaince() async {
    var license = await ModalRoute.of(context)!.settings.arguments as String;
    var data = await InvoiceService.getInvoiceByLicense(license);
    invoices = data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bảo dưỡng'),
        ),
        body: FutureBuilder(
            future: getMaintaince(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return invoices.isNotEmpty
                  ? ListView.builder(
                      itemCount: invoices.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InvoiceCard(invoice: invoices[index]);
                      })
                  : Center(
                      child: Text('Không có lịch sử bảo dưỡng'),
                    );
            }));
  }
}
