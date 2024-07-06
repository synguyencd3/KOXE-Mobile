import 'package:flutter/material.dart';
import 'package:mobile/model/salon_payment_response.dart';

import '../../services/salon_service.dart';
import '../loading.dart';
import 'createPayment.dart';

class SalonPaymentPage extends StatefulWidget {
  @override
  _CustomObjectListPageState createState() => _CustomObjectListPageState();
}

class _CustomObjectListPageState extends State<SalonPaymentPage> {
  Set<String> _permission = {};
  List<SalonPaymentModel> _payments = [];
  bool isLoading = false;

  void getPermission() async {
    var data = await SalonsService.getPermission();
    setState(() {
      _permission = data;
    });
  }

  void getPayment() async {
    setState(() {
      isLoading =true;
    });
    var data = await SalonsService.getPayment();
    setState(() {
      _payments = data;
      isLoading = false;
    });
  }
  List<SalonPaymentModel> objects = [
    SalonPaymentModel(
      createDate: '2024-06-30',
      id: '1',
      custormerPhone: '1234567890',
      custormerFullname: 'John Doe',
      reason: 'First mock reason',
      amount: 100,
      status: true,
    ),
    SalonPaymentModel(
      createDate: '2024-06-29',
      id: '2',
      custormerPhone: '0987654321',
      custormerFullname: 'Jane Smith',
      reason: 'Second mock reason',
      amount: 200,
      status: false,
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermission();
    getPayment();
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
               // Navigator.pushNamed(context, '/new_car');
                showForm(context);
              },
              icon: Icon(Icons.add),
              label: Text('Tạo phiếu thanh toán'))
              : Container(),
          Expanded(
            child: isLoading == true? const Loading() : ListView.builder(
              itemCount: _payments.length,
              itemBuilder: (context, index) {
                SalonPaymentModel obj = _payments[index];
                return Card(
                  child: ListTile(
                    title: Text(obj.custormerFullname ?? 'No Name', style: const TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Điện thoại: ',style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(obj.custormerPhone ?? 'Không có'),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Đơn thanh toán: ',style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(obj.reason ?? 'Không có'),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Thành tiền: ', style: TextStyle(fontWeight: FontWeight.bold),),
                            Text('\$${obj.amount ?? 0}'),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Trạng thái: ', style: TextStyle(fontWeight: FontWeight.bold),),
                            Text('${obj.status ?? false ? 'Chưa thanh toán' : 'Đã thanh toán'}',
                              style: TextStyle(color: obj.status ?? false ? Colors.red : Colors.green ),),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Ngày tạo: ',style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(obj.createDate ?? 'Không có'),
                          ],
                        ),
                      ],
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