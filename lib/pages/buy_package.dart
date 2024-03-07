import 'package:flutter/material.dart';
import 'package:mobile/widgets/dropdown.dart';
import 'package:mobile/widgets/button.dart';

class BuyPackage extends StatelessWidget {
  const BuyPackage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh toán'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mã hóa đơn: 1'),
            Text('Ngày mua: 2021-10-10'),
            Text(
              'Thông tin gói được mua',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Gói 1',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                    Text('Mô tả'),
                  ],
                ),
              ),
            ),
            Text(
              'Thông tin người mua',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Nguyễn Văn A',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                    Text('Email'),
                  ],
                ),
              ),
            ),
            Text(
              'Tổng tiền',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ListTile(
                      leading: Text('Tổng tiền mua gói 1',style: TextStyle(fontSize: 18),),
                      trailing: Text('100.000 đ',style: TextStyle(fontSize: 18)),
                    ),
                    ListTile(
                      leading: Text('Giảm giá',style: TextStyle(fontSize: 18)),
                      trailing: Text('0 đ',style: TextStyle(fontSize: 18)),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    ListTile(
                      leading: Text('Tổng cộng',style: TextStyle(fontSize: 18)),
                      trailing: Text('100.000 đ',style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownMenuExample(
              width: 300,
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.bottomRight,
              child: ButtonCustom(
                onPressed: () {
                  print('Thanh toán');
                },
                title: 'Thanh toán',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
