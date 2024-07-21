import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/salon_payment_response.dart';

import '../../model/Payment_Method_Response.dart';
import '../../services/salon_service.dart';
import '../loading.dart';
import 'createPayment.dart';
import 'package:mobile/utils/utils.dart';

class SalonPaymentPage extends StatefulWidget {
  @override
  _CustomObjectListPageState createState() => _CustomObjectListPageState();
}

class _CustomObjectListPageState extends State<SalonPaymentPage> {
  Set<String> _permission = {};
  List<SalonPaymentModel> _payments = [];
  bool isLoading = false;
  List<PaymentMethod> _methods = [];

  void getPermission() async {
    var data = await SalonsService.getPermission();
    setState(() {
      _permission = data;
    });
  }

  void _fetchMethod() async {
    var data = await SalonsService.getPaymentMethods();
    setState(() {
      _methods = data;
    });
  }

  void getPayment() async {
    setState(() {
      isLoading = true;
    });
    var data = await SalonsService.getPayment();
    setState(() {
      _payments = data;
      isLoading = false;
    });
  }

  void showInvoiceDialog(BuildContext context, SalonPaymentModel obj) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Chi tiết'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  ListTile(
                    title: Text('Ngày tạo'),
                    subtitle: Text(formatDate(DateTime.parse(obj.createDate ?? ""))),
                  ),
                  ListTile(
                      title: Text('Số điện thoại'),
                      subtitle: Text(obj.custormerPhone ?? "")),
                  ListTile(
                      title: Text('Tên khách hàng'),
                      subtitle: Text(obj.custormerFullname ?? "")),
                  ListTile(
                      title: Text('Nội dung'),
                      subtitle: Text(obj.reason ?? "")),
                  // ListTile(title: Text('Creator'), subtitle: Text(obj.creator ?? "")),
                  ListTile(
                      title: Text('Phương thức'),
                      subtitle: Text(obj.payment_method ?? "")),
                  ListTile(
                      title: Text('Số tiền'),
                      subtitle: Text(formatCurrency(obj.amount ?? 0))),
                  ListTile(
                      title: Text('Trạng thái'),
                      subtitle: Text(obj.status == true
                          ? 'Hoàn thành'
                          : 'Chưa hoàn thành')),
                ],
              ),
            ),
          );
        });
  }

  void confirmPayment(String id) async {
    await SalonsService.salonConfirm(id).then((value) => {
          if (value)
            {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Xác nhận thành công'),
                backgroundColor: Colors.green,
              ))
            }
          else
            {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Có lỗi xảy ra, vui lòng thử lại sau'),
                backgroundColor: Colors.red,
              ))
            }
        });
    getPayment();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermission();
    getPayment();
    _fetchMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phiếu thanh toán'),
      ),
      body: Column(
        children: [
          _permission.contains("OWNER") || _permission.contains("C_PMSL")
              ? TextButton.icon(
                  onPressed: () {
                    //var unpayed = _payments.where((e) => e.status == true).toList();
                    showForm(context, _methods);
                  },
                  icon: Icon(Icons.add),
                  label: Text('Tạo phiếu thanh toán'))
              : Container(),
          Expanded(
            child: isLoading == true
                ? const Loading()
                : ListView.builder(
                    itemCount: _payments.length,
                    itemBuilder: (context, index) {
                      SalonPaymentModel obj = _payments[index];
                      return GestureDetector(
                        onTap: () {
                          showInvoiceDialog(context, obj);
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(
                              obj.custormerFullname ?? 'No Name',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Điện thoại: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(obj.custormerPhone ?? 'Không có'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Đơn thanh toán: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(obj.reason ?? 'Không có'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Thành tiền: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(formatCurrency(obj.amount ?? 0)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Phương thức: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(obj.payment_method ?? ""),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Trạng thái: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${obj.status ?? false ? 'Đã thanh toán' : 'Chưa thanh toán'}',
                                      style: TextStyle(
                                          color: obj.status ?? false
                                              ? Colors.green
                                              : Colors.red),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Ngày tạo: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(formatDate(
                                        DateTime.parse(obj.createDate ?? ""))),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        confirmPayment(obj.id ?? "");
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.check),
                                            Text('xác nhận thanh toán')
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
