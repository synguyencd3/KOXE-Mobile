import 'package:flutter/material.dart';
import 'package:mobile/model/car_model.dart';
import 'package:mobile/services/cars_service.dart';

class CarDetail extends StatefulWidget {
  @override
  State<CarDetail> createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
   Car car = new Car();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Future.delayed(Duration.zero, () {
      initCar();
   });
  }
  void initCar() {
    var data = ModalRoute.of(context)!.settings.arguments as Map;
    print(data['car']);
    setState(() {
      car=data['car'];
    });
  }
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
                    trailing: Text('${car.name}', style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
                  ListTile(
                    title: Text('Giá',style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text('${car.price}', style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
                  ListTile(
                    title: Text('Mô tả',style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text('${car.description}', style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
                  ListTile(
                    title: Text('Dòng xe',style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text('${car.type}', style: TextStyle(color: Colors.grey[800], fontSize: 16)),
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
