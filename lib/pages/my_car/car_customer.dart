import 'package:flutter/material.dart';
import 'package:mobile/model/CarInvoice_response.dart';
import 'package:mobile/model/chat_user_model.dart';
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

    // for (var invoice in data) {
    //   if (invoice.done == false) {
    //     data.remove(invoice);
    //   }
    // }
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
                ? Center(child: Text('Không có xe nào'))
                : ListView.builder(
                    itemCount: invoices.length,
                    itemBuilder: (context, index) {
                      final invoice = invoices[index];
                      return invoice.done == false
                          ? Container()
                          : Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Tên xe: ${invoice.carName!.length > 10 ? invoice.carName!.substring(0, 10) + '...' : invoice.carName}'),
                                        Text(
                                            'Biển số: ${invoice.licensePlate ?? 'Chưa có'}'),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              //print(invoice.legalsUser!.carId);
                                              Navigator.pushNamed(context,
                                                  '/car_detail_customer',
                                                  arguments: invoice
                                                      .legalsUser!.carId);
                                            },
                                            child: Text('Xem thông tin xe')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, '/car_warranty',
                                                  arguments: invoice
                                                      .legalsUser!.carId);
                                            },
                                            child: Text('Xem bảo hành')),
                                        invoice.licensePlate != null
                                            ? TextButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(context,
                                                      '/car_maintaince',
                                                      arguments:
                                                          invoice.licensePlate);
                                                },
                                                child: Text(
                                                    'Xem lịch sử bảo dưỡng'))
                                            : Container(),
                                        TextButton(
                                            onPressed: () async {
                                              print(invoice.legalsUser!.carId!);
                                              ChatUserModel user =
                                                  ChatUserModel(
                                                reason: 'Bảo dưỡng xe',
                                                id: invoice.seller?.salonId ??
                                                    '',
                                                carId:
                                                    invoice.legalsUser!.carId!,
                                                name:
                                                    invoice.seller?.name ?? '',
                                              );
                                              Navigator.pushNamed(context,
                                                  '/create_appointment',
                                                  arguments: user);
                                            },
                                            child: Text('Đặt lịch bảo dưỡng'))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                    },
                  );
          }),
    );
  }
}
