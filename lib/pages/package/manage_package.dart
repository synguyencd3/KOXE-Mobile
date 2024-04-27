import 'package:flutter/material.dart';
import 'package:mobile/pages/login.dart';
import 'package:mobile/widgets/button.dart';

class ManagePackage extends StatefulWidget {
  const ManagePackage({super.key});

  @override
  State<ManagePackage> createState() => _ManagePackageState();
}

class _ManagePackageState extends State<ManagePackage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý gói'),
      ),
      body: Column(
        children: [
          Text(
            'Gói đang sử dụng',
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
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Gói 1',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                  Text('Ngày đăng ký: 2021-10-10'),
                  Text('Ngày hết hạn: 2021-10-10'),
                  Text('Mô tả'),
                  SizedBox(height: 10,),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonCustom(onPressed: (){}, title: 'Gia hạn gói'),
                      ButtonCustom(onPressed: (){}, title: 'Nâng cấp gói'),
                      ButtonCustom(onPressed: (){}, title: 'Hủy gói'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
