import 'package:flutter/material.dart';
import 'package:mobile/model/car_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarDetail extends StatefulWidget {
  @override
  State<CarDetail> createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  Car car = new Car();
  late final PageController pageController;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      initCar();
    });
    super.initState();
  }

  void initCar() {
    var data = ModalRoute.of(context)!.settings.arguments as Map;
    if (data.isNotEmpty)
      {
        setState(() {
          car = data['car'];
        });
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(car.name ?? ''),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // CarouselSlider(
            //   options: CarouselOptions(height: 200.0),
            //   items: car.image != null ? car.image!.map((i) {
            //     return Builder(
            //       builder: (BuildContext context) {
            //         return Container(
            //             width: MediaQuery.of(context).size.width,
            //             margin: EdgeInsets.symmetric(horizontal: 5.0),
            //             decoration: BoxDecoration(color: Colors.amber),
            //             child: Image.network(i ?? '' , fit: BoxFit.cover, width: double.infinity, height: 200.0,));
            //       },
            //     );
            //   }).toList() : [],
            // ),
            Text(
              '${car.name}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text(
              '${car.price} VNĐ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Thông tin chi tiết",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Divider(height: 5),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  ListTile(
                    title: Text('Xuất xứ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(car.origin !='' ? '${car.origin}' : 'Chưa cập nhật',
                        style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
                  ListTile(
                    title: Text('Nhãn hiệu',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(car.brand!='' ? '${car.brand}' : 'Chưa cập nhật',
                        style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
                  ListTile(
                    title: Text('Dòng xe',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text('${car.type}',
                        style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
                  ListTile(
                    title: Text('Mẫu xe',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(car.model!='' ? '${car.model}' : 'Chưa cập nhật',
                        style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
                  ListTile(
                    title: Text('Số chỗ ngồi',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(car.capacity !=null ? '${car.capacity}' : 'Chưa cập nhật',
                        style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
                  ListTile(
                    title: Text('Số cửa',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(car.door !=null ? '${car.door}' : 'Chưa cập nhật',
                        style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
                  ListTile(
                    title: Text('Số kilometer đã đi',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(car.kilometer !=null ? '${car.kilometer}' : 'Chưa cập nhật',
                        style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
                  ListTile(
                    title: Text('Gear',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(car.gear !=null ? '${car.gear}' : 'Chưa cập nhật',
                        style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
                  ListTile(
                    title: Text('Ngày sản xuất',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(car.mfg !=null ? '${car.mfg}' : 'Chưa cập nhật',
                        style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
                  ListTile(
                    title: Text('Màu ngoại thất',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(car.outColor !='' ? '${car.outColor}' : 'Chưa cập nhật',
                        style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
        
                  Divider(height: 5),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Mô tả",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Text(
                    '${car.description}',
                    style: TextStyle(color: Colors.grey[800], fontSize: 16),
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
