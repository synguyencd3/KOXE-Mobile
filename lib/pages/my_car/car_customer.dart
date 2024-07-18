import 'package:flutter/material.dart';
import 'package:mobile/model/CarInvoice_response.dart';
import 'package:mobile/model/chat_user_model.dart';
import 'package:mobile/services/CarInvoice_Service.dart';
import 'package:mobile/pages/loading.dart';
import 'package:mobile/utils/utils.dart';

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
              return Loading();
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
                                        Text(
                                            'Ngày mua: ${formatDate(DateTime.parse(invoice.createAt ?? ''))}'),
                                        Text(
                                            'Mua tại: ${invoice.seller?.name ?? 'Chưa có'}'),
                                      ],
                                    ),
                                    PopupMenuButton<String>(
                                      onSelected: (value) async {
                                        switch (value) {
                                          case 'detail':
                                            Navigator.pushNamed(
                                                context, '/car_detail_customer',
                                                arguments:
                                                    invoice.legalsUser!.carId);
                                            break;
                                          case 'warranty':
                                            Navigator.pushNamed(
                                                context, '/car_warranty',
                                                arguments:
                                                    invoice.legalsUser!.carId);
                                            break;
                                          case 'maintaince':
                                            if (invoice.licensePlate != null) {
                                              Navigator.pushNamed(
                                                  context, '/car_maintaince',
                                                  arguments:
                                                      invoice.licensePlate);
                                            }
                                            break;
                                          case 'appointment':
                                            print(invoice.legalsUser!.carId!);
                                            ChatUserModel user = ChatUserModel(
                                              reason: 'Bảo dưỡng xe',
                                              id: invoice.seller?.salonId ?? '',
                                              carId: invoice.legalsUser!.carId!,
                                              name: invoice.seller?.name ?? '',
                                            );
                                            Navigator.pushNamed(
                                                context, '/create_appointment',
                                                arguments: user);
                                            break;
                                        }
                                      },
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry<String>>[
                                        const PopupMenuItem<String>(
                                          value: 'detail',
                                          child: Text('Xem thông tin xe'),
                                        ),
                                        const PopupMenuItem<String>(
                                          value: 'warranty',
                                          child: Text('Xem bảo hành'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'maintaince',
                                          child: invoice.licensePlate != null
                                              ? Text('Xem lịch sử bảo dưỡng')
                                              : null,
                                        ),
                                        const PopupMenuItem<String>(
                                          value: 'appointment',
                                          child: Text('Đặt lịch bảo dưỡng'),
                                        ),
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
