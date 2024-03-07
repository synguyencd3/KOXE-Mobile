import 'package:flutter/material.dart';
import 'package:mobile/model/car.dart';

class CarDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Detail'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  Image.asset('assets/1.png'),
                  ListTile(
                    title: Text('Tên xe', style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text('Xe điện', style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
                  ListTile(
                    title: Text('Giá',style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text('1000000', style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
                  ListTile(
                    title: Text('Mô tả',style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text('Xe điện', style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
                  ListTile(
                    title: Text('Dòng xe',style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text('1', style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
                  ListTile(
                    title: Text('Số lượng',style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text('1', style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
                  ListTile(
                    title: Text('Tình trạng',style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text('Còn hàng', style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
