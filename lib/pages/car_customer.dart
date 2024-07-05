import 'package:flutter/material.dart';
import 'package:mobile/model/CarInvoice_response.dart';
import 'package:mobile/services/CarInvoice_Service.dart';

class CarCustomer extends StatefulWidget {
  const CarCustomer({super.key});

  @override
  State<CarCustomer> createState() => _CarCustomerState();
}

class _CarCustomerState extends State<CarCustomer> {
  List<CarInvoice> invoices = [];

  Future<void> getInvoices() async {
    var data = await CarInvoiceService.getAllCustomer();
    invoices = data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xe của tôi'),
      ),
      body: FutureBuilder(
          future: getInvoices(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return invoices.isEmpty
                ? Center(child: Text('Không có lượt giao dịch nào'))
                : ListView.builder(
                    itemCount: invoices.length,
                    itemBuilder: (context, index) {
                      final invoice = invoices[index];
                      return Card(
                        child: ListTile(
                          title: Text(invoice.carName!),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/transaction_detail_navigator',
                                arguments: invoice);
                          },
                        ),
                      );
                    },
                  );
          }),
    );
  }
}
