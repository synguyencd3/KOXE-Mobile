import 'package:flutter/material.dart';
import 'package:mobile/model/accessory_invoice_model.dart';

import '../services/accessory_service.dart';
import 'package:mobile/pages/loading.dart';

class UserAccessory extends StatefulWidget {
  const UserAccessory({super.key});

  @override
  State<UserAccessory> createState() => _UserAccessoryState();
}

class _UserAccessoryState extends State<UserAccessory> {
  List<AccessoryInvoiceModel> accessoryInvoices = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getAllAccessoryInvoice();
    });
  }

  Future<void> getAllAccessoryInvoice() async {
    List<AccessoryInvoiceModel> accessoryInvoiceAPI =
        await AccessoryService.getAccessoryInvoices();
    accessoryInvoices = accessoryInvoiceAPI;
  }

  void showDialogDetail(AccessoryInvoiceModel invoice) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      'Thông tin hóa đơn',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  simpleInvoiceCard(invoice),
                  Divider(
                    height: 20,
                  ),
                  ListTile(
                    title: Text(
                      'Thông tin salon',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Tên salon', style: TextStyle(),),
                   trailing: Text(invoice.salonName ?? '' ,style: TextStyle(fontSize: 16),),
                  ),
                  Divider(
                    height: 20,
                  ),
                  ListTile(
                    title: Text(
                      'Danh sách phụ tùng đã mua',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  for (var service in invoice.accessories)
                    ListTile(
                      title: Text(service.name ?? ''),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Số lượng: ' + service.quantity.toString()),
                          Text('Giá: ' + service.price.toString()),
                        ],
                      ),
                    ),
                  Divider(
                    height: 20,
                  ),
                  ListTile(
                    title: Text(
                      'Ghi chú',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(invoice.note ?? 'Không có',
                        style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hóa đơn phụ tùng'),
      ),
      body: FutureBuilder(
          future: getAllAccessoryInvoice(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }
            return accessoryInvoices.isEmpty
                ? Center(
                    child: Text('Không có hóa đơn nào'),
                  )
                : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: accessoryInvoices.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            simpleInvoiceCard(accessoryInvoices[index]),
                            IconButton(
                                onPressed: () {
                                  showDialogDetail(accessoryInvoices[index]);
                                },
                                icon: Icon(Icons.info)),
                          ],
                        ),
                      );
                    },
                  );
          }),
    );
  }
}

Widget simpleInvoiceCard(AccessoryInvoiceModel invoice) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
    child: Column(
      children: [
        ListTile(
          title: Text(
            'Ngày mua: ' + (invoice.invoiceDate ?? ''),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          title: Text(
            'Họ tên',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Text(invoice.fullname, style: TextStyle(fontSize: 16)),
        ),
        ListTile(
          title: Text(
            'Số điện thoại',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Text(invoice.phone, style: TextStyle(fontSize: 16)),
        ),
        ListTile(
          title: Text(
            'Tổng chi phí',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing:
              Text(invoice.total.toString(), style: TextStyle(fontSize: 16)),
        ),
      ],
    ),
  );
}
