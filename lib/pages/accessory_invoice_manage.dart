import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/model/accessory_invoice_model.dart';
import 'package:mobile/model/accessory_model.dart';
import 'package:mobile/pages/loading.dart';
import 'package:mobile/services/accessory_service.dart';

class AccessoryInvoiceManage extends StatefulWidget {
  const AccessoryInvoiceManage({super.key});

  @override
  State<AccessoryInvoiceManage> createState() => _AccessoryInvoiceManageState();
}

class _AccessoryInvoiceManageState extends State<AccessoryInvoiceManage> {
  List<AccessoryInvoiceModel> accessoryInvoices = [];
  List<AccessoryModel> accessories = [];
  List<String> selectedAccessoryIds = [];
  Map<String, int> accessoryQuantities = {};
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getAllAccessoryInvoice();
      getAllAccessories();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    noteController.dispose();
    super.dispose();
  }

  Future<void> getAllAccessoryInvoice() async {
    List<AccessoryInvoiceModel> accessoryInvoiceAPI =
        await AccessoryService.getAccessoryInvoices();
    accessoryInvoices = accessoryInvoiceAPI;
  }

  Future<void> getAllAccessories() async {
    List<AccessoryModel> accessoriesAPI =
        await AccessoryService().getAccessoriesSalon();
    setState(() {
      accessories = accessoriesAPI;
    });
  }

  Future<void> deleteAccessoryInvoice(String id) async {
    bool response = await AccessoryService.deleteAcessoryInvoice(id);
    if (response) {
      setState(() {
        accessoryInvoices.removeWhere((element) => element.id == id);
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Xóa hóa đơn thành công'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Xóa hóa đơn không thành công'),
      ));
    }
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
                    title: Text(
                      'Tên salon',
                      style: TextStyle(),
                    ),
                    trailing: Text(
                      invoice.salonName ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
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

  @override
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
                : Column(
                    children: [
                      TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Thêm hóa đơn'),
                                    content: StatefulBuilder(
                                        builder: (context, setState) {
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            TextField(
                                              decoration: InputDecoration(
                                                labelText: 'Họ tên',
                                              ),
                                              controller: nameController,
                                            ),
                                            TextField(
                                              decoration: InputDecoration(
                                                labelText: 'Số điện thoại',
                                              ),
                                              controller: phoneController,
                                            ),
                                            TextField(
                                              decoration: InputDecoration(
                                                labelText: 'Email',
                                              ),
                                              controller: emailController,
                                            ),
                                            TextField(
                                              decoration: InputDecoration(
                                                labelText: 'Note',
                                              ),
                                              controller: noteController,
                                            ),
                                            Text('Chọn phụ tùng'),
                                            for (var accessory in accessories)
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: CheckboxListTile(
                                                      title: Text(
                                                          accessory.name ?? ''),
                                                      value:
                                                          selectedAccessoryIds
                                                              .contains(
                                                                  accessory.id),
                                                      onChanged: (value) {
                                                        if (value == true) {
                                                          setState(() {
                                                            selectedAccessoryIds
                                                                .add(accessory
                                                                        .id ??
                                                                    '');
                                                          });
                                                        } else {
                                                          setState(() {
                                                            selectedAccessoryIds
                                                                .remove(
                                                                    accessory
                                                                        .id);
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  if (selectedAccessoryIds
                                                      .contains(accessory
                                                          .id)) // Only show quantity selector if checked
                                                    DropdownButton<int>(
                                                      value:
                                                          accessoryQuantities[
                                                              accessory.id ??
                                                                  ''],
                                                      items: List.generate(
                                                              10,
                                                              (index) =>
                                                                  index +
                                                                  1) // Change this to your desired range
                                                          .map<
                                                              DropdownMenuItem<
                                                                  int>>((int
                                                              value) {
                                                        return DropdownMenuItem<
                                                            int>(
                                                          value: value,
                                                          child: Text(
                                                              value.toString()),
                                                        );
                                                      }).toList(),
                                                      onChanged:
                                                          (int? newValue) {
                                                        setState(() {
                                                          accessoryQuantities[
                                                                  accessory
                                                                          .id ??
                                                                      ''] =
                                                              newValue!;
                                                        });
                                                      },
                                                    ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      );
                                    }),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Hủy')),
                                      TextButton(
                                          onPressed: () async {
                                            AccessoryInvoiceModel
                                                accessoryInvocice =
                                                AccessoryInvoiceModel(
                                              fullname: nameController.text,
                                              phone: phoneController.text,
                                              email: emailController.text,
                                              note: noteController.text,
                                              accessories: selectedAccessoryIds
                                                  .map((id) => AccessoryModel(
                                                      id: id,
                                                      quantity:
                                                          accessoryQuantities[
                                                              id]))
                                                  .toList(),
                                            );
                                            bool response =
                                                await AccessoryService
                                                    .createAccessoryInvoice(
                                                        accessoryInvocice);
                                            if (response) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Thêm hóa đơn thành công'),
                                              ));
                                              setState(() {
                                                accessoryInvoices
                                                    .add(accessoryInvocice);
                                              });
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Thêm hóa đơn không thành công'),
                                              ));
                                            }
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Xác nhận')),
                                    ],
                                  );
                                });
                          },
                          child: Text('Thêm hóa đơn')),
                      Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: accessoryInvoices.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                children: [
                                  simpleInvoiceCard(accessoryInvoices[index]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            showDialogDetail(
                                                accessoryInvoices[index]);
                                          },
                                          icon: Icon(Icons.info)),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(context: context, builder: (context){
                                              return AlertDialog(
                                                content: Text('Bạn có chắc chắn muốn xóa hóa đơn này không?'),
                                                actions: [
                                                  TextButton(onPressed: (){
                                                    Navigator.of(context).pop();
                                                  }, child: Text('Hủy')),
                                                  TextButton(onPressed: (){
                                                    Navigator.of(context).pop();
                                                    setState(() {
                                                      accessoryInvoices.removeAt(index);
                                                    });
                                                    deleteAccessoryInvoice(
                                                        accessoryInvoices[index].id ??
                                                            '');
                                                  }, child: Text('Xác nhận')),
                                                ]
                                              );
                                            });
                                          },
                                          icon: Icon(Icons.delete)),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
