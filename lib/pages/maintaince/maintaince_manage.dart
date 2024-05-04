import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/model/invoice_model.dart';
import 'package:mobile/services/maintaince_service.dart';
import 'package:mobile/model/maintaince_model.dart';
import 'package:mobile/pages/loading.dart';
import 'package:mobile/widgets/accessory_checkbox.dart';
import 'package:mobile/widgets/invoice_card.dart';
import 'package:mobile/widgets/maintaince_card.dart';
import 'package:mobile/services/invoice_service.dart';
import 'package:mobile/widgets/dropdown.dart';
import 'package:mobile/widgets/maintaince_checkbox.dart';
import 'package:mobile/model/maintaince_request_model.dart';

import '../../model/accessory_model.dart';
import '../../model/accessory_request_model.dart';
import '../../services/accessory_service.dart';

class MaintainceManage extends StatefulWidget {
  const MaintainceManage({super.key});

  @override
  State<MaintainceManage> createState() => _MaintainceManageState();
}

class _MaintainceManageState extends State<MaintainceManage>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(text: 'Các gói bảo dưỡng'),
    Tab(text: 'Hóa đơn bảo dưỡng'),
  ];
  late final TabController _tabController;
  List<MaintainceModel> maintainces = [];
  List<InvoiceModel> invoices = [];
  List<AccessoryModel> accessories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    Future.delayed(Duration.zero, () {
      getAllAccessories();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  Future<void> getAllMaintainces() async {
    List<MaintainceModel> maintaincesAPI =
        await MaintainceService().getAllMaintainces();
    print(maintaincesAPI.length);
    maintainces = maintaincesAPI;
  }

  Future<void> getAllAccessories() async {
    List<AccessoryModel> accessoriesAPI =
        await AccessoryService().getAccessoriesSalon();
    setState(() {
      accessories = accessoriesAPI;
    });
  }

  Future<void> getAllInvoices() async {
    List<InvoiceModel> invoicesAPI = await InvoiceService().getAllInvoices();
    invoices = invoicesAPI;
  }

  Future<bool> addMaintaincePackage(MaintainceModel maintaince) async {
    bool response = await MaintainceService().addMaintaincePackage(maintaince);
    return response;
  }

  Future<bool> addInvoice(InvoiceModel invoice) async {
    bool response = await InvoiceService().addInvoice(invoice);
    return response;
  }

  void showAddMaintainceDialog(BuildContext context) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final costController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thêm gói bảo dưỡng'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Tên gói',
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Mô tả gói',
                ),
              ),
              TextField(
                controller: costController,
                decoration: InputDecoration(
                  labelText: 'Giá tiền',
                ),
              ),
            ],
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
                // Handle OK button press
                MaintainceModel maintaince = MaintainceModel(
                  name: nameController.text,
                  description: descriptionController.text,
                  cost: int.parse(costController.text),
                );

                bool response = await addMaintaincePackage(maintaince);
                if (response) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Thêm gói bảo dưỡng thành công'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  setState(() {
                    maintainces.add(maintaince);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Thêm gói bảo dưỡng thất bại'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                  SizedBox(height: 10),
                  Text('Chọn gói bảo dưỡng' , style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
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
                  Text('Chọn phụ tùng sử dụng', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
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
                        content: Text('Thêm gói bảo dưỡng thành công'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    setState(() {
                      invoices.add(invoice);
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Thêm gói bảo dưỡng thất bại'),
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
        title: Text('Quản lý bảo dưỡng'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TabBar(
              tabs: tabs,
              controller: _tabController,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  FutureBuilder(
                      future: getAllMaintainces(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Loading();
                        }
                        return maintainces.isEmpty
                            ? Center(
                                child: TextButton(
                                    onPressed: () {
                                      showAddMaintainceDialog(context);
                                    },
                                    child: Text('Thêm gói bảo dưỡng',
                                        style: TextStyle(
                                            fontSize: 20))),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        showAddMaintainceDialog(context);
                                      },
                                      child: Text('Thêm gói bảo dưỡng',
                                          style: TextStyle(
                                              fontSize: 20))),
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: maintainces.length,
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.only(top: 1),
                                        itemBuilder: (context, index) {
                                          return MaintainceCard(
                                              maintaince: maintainces[index]);
                                        }),
                                  ),
                                ],
                              );
                      }),
                  FutureBuilder(
                      future: getAllInvoices(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Loading();
                        }
                        return invoices.isEmpty
                            ? Center(
                                child: TextButton(
                                    onPressed: () {
                                      showAddInvoiceDialog(context);
                                    },
                                    child: Text('Thêm hóa đơn bảo dưỡng',
                                        style: TextStyle(
                                            fontSize: 20))))
                            : Column(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        showAddInvoiceDialog(context);
                                      },
                                      child: Text('Thêm hóa đơn bảo dưỡng',
                                          style: TextStyle(
                                              fontSize: 20,
                                          ))),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
