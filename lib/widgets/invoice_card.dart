import 'package:flutter/material.dart';
import 'package:mobile/model/invoice_model.dart';
import 'package:mobile/services/invoice_service.dart';
import 'package:mobile/services/salon_service.dart';

class InvoiceCard extends StatefulWidget {
  final InvoiceModel invoice;

  const InvoiceCard({super.key, required this.invoice});

  @override
  State<InvoiceCard> createState() => _InvoiceCardState();
}

class _InvoiceCardState extends State<InvoiceCard> {
  Set<String> permission = {};
  bool isShow = true;

  void showDialogDetail() {
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
                      'Ngày tạo',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(widget.invoice.createAt ?? '',
                        style: TextStyle(fontSize: 16)),
                  ),
                  ListTile(
                    title: Text(
                      'Thông tin hóa đơn',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  simpleInvoiceCard(widget.invoice),
                  Divider(
                    height: 20,
                  ),
                  ListTile(
                    title: Text(
                      'Danh sách dịch vụ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  for (var service in widget.invoice.maintainces)
                    ListTile(
                      title: Text(service.name ?? ''),
                      trailing: Text(service.cost.toString()),
                    ),
                  Divider(
                    height: 20,
                  ),
                  ListTile(
                    title: Text(
                      'Danh sách phụ tùng sử dụng',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  for (var accessory in widget.invoice.accessories ?? [])
                    ListTile(
                      title: Text(accessory.name ?? ''),
                      trailing: Text(accessory.price.toString()),
                    ),
                  Divider(
                    height: 20,
                  ),
                  ListTile(
                    title: Text(
                      'Ghi chú',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(widget.invoice.note ?? '',
                        style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void getPermission() async {
    var data = await SalonsService.getPermission();
    setState(() {
      permission = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getPermission();
    });
  }

  Future<void> deleteCard() async {
    bool response = await InvoiceService.deleteInvoice(widget.invoice.id ?? '');
    if (response) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Xóa thành công'),
      ));
      setState(() {
        isShow = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Xóa thất bại'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return isShow
        ? Card(
            child: Column(
            children: [
              ListTile(
                title: Text(
                  'Ngày tạo',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Text(widget.invoice.createAt ?? '',
                    style: TextStyle(fontSize: 16)),
              ),
              simpleInvoiceCard(widget.invoice),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        showDialogDetail();
                      },
                      icon: Icon(Icons.info)),
                  permission.contains("OWNER") || permission.contains("R_IV")
                      ? IconButton(
                          onPressed: () async {
                            await deleteCard();
                          },
                          icon: Icon(Icons.delete))
                      : Container()
                ],
              ),
            ],
          ))
        : Container();
  }

  Widget simpleInvoiceCard(InvoiceModel invoice) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Họ tên',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(invoice.fullName, style: TextStyle(fontSize: 16)),
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
              'Tên xe',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(invoice.carName, style: TextStyle(fontSize: 16)),
          ),
          ListTile(
            title: Text(
              'Tổng chi phí',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(invoice.expense.toString(),
                style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
