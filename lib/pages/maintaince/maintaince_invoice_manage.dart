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

import '../../model/CarInvoice_response.dart';
import '../../model/Payment_Method_Response.dart';
import '../../services/CarInvoice_Service.dart';
import 'package:dropdown_search/dropdown_search.dart';

class MaintainceInvoiceManage extends StatefulWidget {
  const MaintainceInvoiceManage({super.key});

  @override
  State<MaintainceInvoiceManage> createState() =>
      _MaintainceInvoiceManageState();
}

class _MaintainceInvoiceManageState extends State<MaintainceInvoiceManage> {
  List<InvoiceModel> invoices = [];
  List<MaintainceModel> maintainces = [];
  List<AccessoryModel> accessories = [];
  List<PaymentMethod> _methods = [];
  String? _selectedOption;
  List<CarInvoice> carInvoices = [];
  CarInvoice? selectedInvoice;
  List<AccessoryModel> selectedAccessories = [];
  List<MaintainceModel> selectedMaintainces = [];
  List<TextEditingController> quantityControllers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getAllInvoices();
      getAllAccessories();
      getAllMaintainces();
      _fetchMethod();
      getInvoices();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    quantityControllers.forEach((element) {
      element.dispose();
    });
  }

  void getInvoices() async {
    var data = await CarInvoiceService.getAll(null);
    data = data.where((element) => element.done == true).toList();
    setState(() {
      carInvoices = data;
    });
  }

  Future<void> getAllInvoices() async {
    //print('call');
    List<InvoiceModel> invoicesAPI = await InvoiceService().getAllInvoices();
    setState(() {
      invoices = invoicesAPI;
    });
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

  Future<bool> addInvoice(InvoiceModel invoice, String paymentMethodId) async {
    bool response = await InvoiceService().addInvoice(invoice, paymentMethodId);
    return response;
  }

  void showAddInvoiceDialog(BuildContext context) {
    final licenseController = TextEditingController();
    final carNameController = TextEditingController();
    final noteController = TextEditingController();
    final fullNameController = TextEditingController();
    final phoneController = TextEditingController();
    bool _showDropdown = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Thêm hóa đơn bảo dưỡng'),
            content: StatefulBuilder(builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownMenu<CarInvoice>(
                      hintText: "Chọn phiếu thanh toán",
                      width: 286,
                      label: const Text('Phiếu thanh toán'),
                      onSelected: (CarInvoice? menu) {
                        selectedInvoice = menu!;
                        licenseController.text =
                            selectedInvoice?.licensePlate ?? "";
                        carNameController.text = selectedInvoice?.carName ?? "";
                        noteController.text = selectedInvoice?.note ?? "";
                        fullNameController.text =
                            selectedInvoice?.fullname ?? "";
                        phoneController.text = selectedInvoice?.phone ?? "";
                      },
                      dropdownMenuEntries: carInvoices
                          .map<DropdownMenuEntry<CarInvoice>>(
                              (CarInvoice menu) {
                        return DropdownMenuEntry<CarInvoice>(
                          value: menu,
                          label: '${menu.phone}\n${menu.invoiceId}',
                        );
                      }).toList(),
                    ),
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
                    SizedBox(height: 10),
                    DropdownSearch<MaintainceModel>.multiSelection(
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: 'Chọn bảo dưỡng',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                      compareFn: (MaintainceModel? i, MaintainceModel? s) =>
                      i!.id == s!.id,
                      asyncItems: (String filter) =>
                          MaintainceService.getAllMaintaincesSearch(filter),
                      itemAsString: (MaintainceModel u) => u.name ?? '',
                      //items: accessories,
                      popupProps: PopupPropsMultiSelection.dialog(
                        showSearchBox: true,
                        showSelectedItems: false,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            labelText: 'Nhập tên bảo dưỡng',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                          ),
                        ),
                      ),
                      onChanged: (List<MaintainceModel> values) {
                        setState(() {
                          selectedMaintainces = values;
                        });
                      },
                    ),
                    SizedBox(height: 10),
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
                child: Text('Hủy'),
                onPressed: () {
                  selectedMaintainces.clear();
                  selectedAccessories.clear();
                  quantityControllers.clear();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Thêm'),
                onPressed: () async {
                  //print(selectedAcessories);
                  List<MaintainceRequestModel> nonNullSelectedMaintainces =
                      selectedMaintainces
                          .map((e) => MaintainceRequestModel(
                              id: e.id ?? '', quantity: 1))
                          .toList();
                  List<AccessoryRequestModel> nonNullSelectedAccessories =
                      selectedAccessories
                          .map((e) => AccessoryRequestModel(
                              id: e.id ?? '',
                              quantity: int.parse(quantityControllers[
                                      selectedAccessories.indexOf(e)]
                                  .text)))
                          .toList();
                  //print('${nonNullSelectedAccessories[1].quantity} , ${nonNullSelectedAccessories[1].id}');
                  InvoiceModel invoice = InvoiceModel(
                      licensePlate: licenseController.text,
                      carName: carNameController.text,
                      fullName: fullNameController.text,
                      phone: phoneController.text,
                      note: noteController.text,
                      services: nonNullSelectedMaintainces,
                      accessoriesRequest: nonNullSelectedAccessories,
                      invoiceId: selectedInvoice?.invoiceId);
                  bool response =
                      await addInvoice(invoice, _selectedOption ?? "");
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
                  selectedMaintainces.clear();
                  selectedAccessories.clear();
                  quantityControllers.clear();
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
      body: invoices.isEmpty
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
                      return InvoiceCard(invoice: invoices[index]);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
