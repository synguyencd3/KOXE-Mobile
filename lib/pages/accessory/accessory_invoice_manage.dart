import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/model/accessory_invoice_model.dart';
import 'package:mobile/model/accessory_model.dart';
import 'package:mobile/pages/loading.dart';
import 'package:mobile/services/accessory_service.dart';
import 'package:mobile/utils/utils.dart';

import '../../model/Payment_Method_Response.dart';
import '../../services/salon_service.dart';
import 'package:mobile/utils/utils.dart';
import 'package:dropdown_search/dropdown_search.dart';

class AccessoryInvoiceManage extends StatefulWidget {
  const AccessoryInvoiceManage({super.key});

  @override
  State<AccessoryInvoiceManage> createState() => _AccessoryInvoiceManageState();
}

class _AccessoryInvoiceManageState extends State<AccessoryInvoiceManage> {
  List<AccessoryInvoiceModel> accessoryInvoices = [];
  List<AccessoryModel> accessories = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  List<PaymentMethod> _methods = [];
  bool _showDropdown = false;
  String? _selectedOption;
  List<AccessoryModel> selectedAccessories = [];
  List<TextEditingController> quantityControllers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getAllAccessories();
      _fetchMethod();
    });
  }

  void _fetchMethod() async {
    var data = await SalonsService.getPaymentMethods();
    setState(() {
      _methods = data;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    noteController.dispose();
    quantityControllers.forEach((element) {
      element.dispose();
    });
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
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Xóa hóa đơn không thành công'),
        backgroundColor: Colors.red,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Số lượng: ' + service.quantity.toString()),
                          Text('Tổng tiền: ' +
                              formatCurrency(service.price ?? 0)),
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

  void showAddDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Thêm hóa đơn'),
            content: StatefulBuilder(builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    CheckboxListTile(
                      value: _showDropdown,
                      title: const Text('Tạo yêu cầu thanh toán'),
                      onChanged: (value) {
                        setState(() {
                          _showDropdown = value!;
                        });
                      },
                    ),
                    if (_showDropdown)
                      Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: DropdownButtonFormField<String>(
                          value: _selectedOption,
                          onChanged: (value) {
                            setState(() {
                              _selectedOption = value;
                            });
                          },
                          items: _methods
                              .map((e) => DropdownMenuItem(
                                  child: Text(e.type ?? ""), value: e.id))
                              .toList(),
                          decoration: InputDecoration(
                            labelText: 'Chọn phương thức thanh toán',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    const SizedBox(height: 10),
                    DropdownSearch<AccessoryModel>.multiSelection(
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: 'Chọn phụ tùng',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                      compareFn: (AccessoryModel? i, AccessoryModel? s) =>
                          i!.id == s!.id,
                      asyncItems: (String filter) =>
                          AccessoryService.getAccessoriesSalonSearch(filter),
                      itemAsString: (AccessoryModel u) => u.name ?? '',
                      //items: accessories,
                      popupProps: PopupPropsMultiSelection.dialog(
                        showSearchBox: true,
                        showSelectedItems: false,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            labelText: 'Nhập tên phụ tùng',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                          ),
                        ),
                      ),
                      onChanged: (List<AccessoryModel> values) {
                        setState(() {
                          selectedAccessories = values;
                        });
                      },
                    ),
                    selectedAccessories.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Phụ tùng đã chọn',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              ...selectedAccessories.map((e) {
                                selectedAccessories.forEach((_) {
                                  quantityControllers
                                      .add(TextEditingController());
                                });
                                int index = selectedAccessories.indexOf(e);
                                return ListTile(
                                  title: Text(e.name ?? ''),
                                  trailing: Container(
                                    width: 100,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: quantityControllers[index],
                                      decoration: InputDecoration(
                                        labelText: 'Số lượng',
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ],
                          )
                        : Container(),
                  ],
                ),
              );
            }),
            actions: [
              TextButton(
                  onPressed: () {
                    selectedAccessories.clear();
                    quantityControllers.clear();
                    Navigator.of(context).pop();
                  },
                  child: Text('Hủy')),
              TextButton(
                  onPressed: () async {
                    AccessoryInvoiceModel accessoryInvocice =
                        AccessoryInvoiceModel(
                      fullname: nameController.text,
                      phone: phoneController.text,
                      email: emailController.text,
                      note: noteController.text,
                      accessories: selectedAccessories
                          .map((e) => AccessoryModel(
                              id: e.id,
                              quantity: int.parse(quantityControllers[
                                      selectedAccessories.indexOf(e)]
                                  .text)))
                          .toList(),
                    );
                    bool response =
                        await AccessoryService.createAccessoryInvoice(
                            accessoryInvocice, _selectedOption ?? "");
                    if (response) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Thêm hóa đơn thành công'),
                        backgroundColor: Colors.green,
                      ));
                      setState(() {
                        accessoryInvoices.add(accessoryInvocice);
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Thêm hóa đơn không thành công'),
                        backgroundColor: Colors.red,
                      ));
                    }
                    selectedAccessories.clear();
                    quantityControllers.clear();
                    Navigator.of(context).pop();
                  },
                  child: Text('Xác nhận')),
            ],
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
                    child: TextButton.icon(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          showAddDialog();
                        },
                        label: Text('Thêm hóa đơn')),
                  )
                : Column(
                    children: [
                      TextButton.icon(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            showAddDialog();
                          },
                          label: Text('Thêm hóa đơn')),
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
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                      content: Text(
                                                          'Bạn có chắc chắn muốn xóa hóa đơn này không?'),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text('Hủy')),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              setState(() {
                                                                accessoryInvoices
                                                                    .removeAt(
                                                                        index);
                                                              });
                                                              deleteAccessoryInvoice(
                                                                  accessoryInvoices[
                                                                              index]
                                                                          .id ??
                                                                      '');
                                                            },
                                                            child: Text(
                                                                'Xác nhận')),
                                                      ]);
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
          trailing: Text(formatCurrency(invoice.total!).toString(),
              style: TextStyle(fontSize: 16)),
        ),
      ],
    ),
  );
}
