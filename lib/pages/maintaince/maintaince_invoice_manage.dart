

import 'package:flutter/material.dart';
import 'package:mobile/model/accessory_model.dart';
import 'package:mobile/model/accessory_request_model.dart';
import 'package:mobile/model/invoice_model.dart';
import 'package:mobile/model/maintaince_model.dart';
import 'package:mobile/model/maintaince_request_model.dart';
import 'package:mobile/model/payment_request.dart';
import 'package:mobile/pages/loading.dart';
import 'package:mobile/services/accessory_service.dart';
import 'package:mobile/services/invoice_service.dart';
import 'package:mobile/services/maintaince_service.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/widgets/accessory_checkbox.dart';
import 'package:mobile/widgets/invoice_card.dart';
import 'package:mobile/widgets/maintaince_checkbox.dart';

import '../../model/Payment_Method_Response.dart';

class MaintainceInvoiceManage extends StatefulWidget {
  const MaintainceInvoiceManage({super.key});

  @override
  State<MaintainceInvoiceManage> createState() => _MaintainceInvoiceManageState();
}


class _MaintainceInvoiceManageState extends State<MaintainceInvoiceManage> {
  List<InvoiceModel> invoices = [];
  List<MaintainceModel> maintainces = [];
  List<AccessoryModel> accessories = [];
  List<PaymentMethod> _methods = [];
  String? _selectedOption;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getAllAccessories();
      getAllMaintainces();
      _fetchMethod();
    });
  }

  Future<void> getAllInvoices() async {
    List<InvoiceModel> invoicesAPI = await InvoiceService().getAllInvoices();
    invoices = invoicesAPI;
  }

  void _fetchMethod() async {
    var data = await SalonsService.getPaymentMethods();
    setState(() {
      _methods = data;
    });
  }
  Future<void> getAllMaintainces() async {
    List<MaintainceModel> maintaincesAPI =
    await MaintainceService().getAllMaintainces();
    //print(maintaincesAPI.length);
    maintainces = maintaincesAPI;
  }

  Future<void> getAllAccessories() async {
    List<AccessoryModel> accessoriesAPI =
    await AccessoryService().getAccessoriesSalon();
    setState(() {
      accessories = accessoriesAPI;
    });
  }
  Future<bool> addInvoice(InvoiceModel invoice) async {
    bool response = await InvoiceService().addInvoice(invoice);
    return response;
  }

  void showAddInvoiceDialog(BuildContext context) {
    final licenseController = TextEditingController();
    final carNameController = TextEditingController();
    final noteController = TextEditingController();
    final fullNameController = TextEditingController();
    final phoneController = TextEditingController();
    List<String?> selectedMaintainces =
    List<String?>.filled(maintainces.length, null);
    List<String?> selectedAcessories =
    List<String?>.filled(accessories.length, null);
    bool _showDropdown = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Thêm hóa đơn bảo dưỡng'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: licenseController,
                    decoration: InputDecoration(
                      labelText: 'Biển số xe',
                    ),
                  ),
                  TextField(
                    controller: carNameController,
                    decoration: InputDecoration(
                      labelText: 'Tên xe',
                    ),
                  ),
                  TextField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                      labelText: 'Họ tên khách hàng',
                    ),
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Số điện thoại khách hàng',
                    ),
                  ),
                  TextField(
                    controller: noteController,
                    decoration: InputDecoration(
                      labelText: 'Ghi chú',
                    ),
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
                        items: _methods.map((e) => DropdownMenuItem(child: Text(e.type ?? ""), value: e.id)).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select an option',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  SizedBox(height: 10),
                  Text('Chọn gói bảo dưỡng',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ...maintainces.map((maintaince) {
                    int index = maintainces.indexOf(maintaince);
                    return MaintainceCheckbox(
                      maintaince: maintaince,
                      onSelectedChanged: (String? selectedId) {
                        selectedMaintainces[index] = selectedId;
                      },
                    );
                  }).toList(),
                  SizedBox(height: 10),
                  Text('Chọn phụ tùng sử dụng',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ...accessories.map((accessory) {
                    int index = accessories.indexOf(accessory);
                    return AccessoryCheckbox(
                      accessory: accessory,
                      onSelectedChanged: (String? selectedId) {
                        selectedAcessories[index] = selectedId;
                      },
                    );
                  }).toList(),

                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('Hủy'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Thêm'),
                onPressed: () async {
                  print(selectedAcessories);
                  List<MaintainceRequestModel> nonNullSelectedMaintainces =
                  selectedMaintainces
                      .where((element) => element != null)
                      .map((e) => MaintainceRequestModel(id: e ?? ''))
                      .toList();
                  List<AccessoryRequestModel> nonNullSelectedAccessories =
                  selectedAcessories
                      .where((element) => element != null)
                      .map((e) => AccessoryRequestModel(id: e ?? ''))
                      .toList();
                  print(nonNullSelectedAccessories);
                  InvoiceModel invoice = InvoiceModel(
                    licensePlate: licenseController.text,
                    carName: carNameController.text,
                    fullName: fullNameController.text,
                    phone: phoneController.text,
                    note: noteController.text,
                    services: nonNullSelectedMaintainces,
                    accessoriesRequest: nonNullSelectedAccessories,
                  );
                  bool response = await addInvoice(invoice);
                  if (response) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Thêm hóa đơn bảo dưỡng thành công'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    setState(() {
                      invoices.add(invoice);
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Thêm hóa đơn bảo dưỡng thất bại'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hóa đơn bảo dưỡng'),
      ),
      body:   FutureBuilder(
          future: getAllInvoices(),
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return Loading();
            }
            return invoices.isEmpty
                ? Center(
                child: TextButton.icon(
                  icon: Icon(Icons.add),
                    onPressed: () {
                      showAddInvoiceDialog(context);
                    },
                    label: Text(
                      'Thêm hóa đơn bảo dưỡng',
                    )))
                : Column(
              children: [
                TextButton.icon(
                  icon: Icon(Icons.add),
                    onPressed: () {
                      showAddInvoiceDialog(context);
                    },
                    label: Text(
                      'Thêm hóa đơn bảo dưỡng',
                    )),
                Expanded(
                  child: ListView.builder(
                    itemCount: invoices.length,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 1),
                    itemBuilder: (context, index) {
                      return InvoiceCard(
                          invoice: invoices[index]);
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }
}
