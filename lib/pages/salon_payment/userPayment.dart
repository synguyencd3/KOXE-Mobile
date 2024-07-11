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

  void confirmPayment(String id) async {
      await SalonsService.userConfirm(id).then((value) => {
      if (value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Xác nhận thành công, vui lòng đợi liên hệ từ salon'),
            backgroundColor: Colors.green,
          ))
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Có lỗi xảy ra, vui lòng thử lại sau'),
        backgroundColor: Colors.red,
        ))
    }
      });
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
                        Text('${obj.status ?? false ? 'Đã thanh toán': 'Chưa thanh toán' }',
                          style: TextStyle(color: obj.status ?? false ? Colors.green : Colors.red ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Ngày tạo: ',style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(obj.createDate ?? 'Không có'),
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
            );
          },
        ),
      ),
    );
  }
}