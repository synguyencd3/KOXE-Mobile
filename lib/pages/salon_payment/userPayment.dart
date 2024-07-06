import 'package:flutter/material.dart';
import 'package:mobile/model/salon_payment_response.dart';

import '../../services/salon_service.dart';
import '../loading.dart';
import 'createPayment.dart';

class UserPaymentPage extends StatefulWidget {
  @override
  _CustomObjectListPageState createState() => _CustomObjectListPageState();
}

class _CustomObjectListPageState extends State<UserPaymentPage> {
  List<SalonPaymentModel> _payments = [];
  bool isLoading = false;

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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPayment();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phiếu thanh toán'),
      ),
      body: Expanded(
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
    );
  }
}