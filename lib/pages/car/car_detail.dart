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
    setState(() {
      car=data['car'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Car Detail'),
      ),
      body: Column(
        children: [
          CarouselSlider(
              options: CarouselOptions(height: 200.0),
              items: car.image?.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.amber
                      ),
                      child: Image.network(i)
                    );
                  },
                );
              }).toList(),
            ),

                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Thông tin chi tiết",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.left,),
                  ),
                ),
           Divider(height: 5),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                ListTile(
                  title: Text('Tên xe', style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: Text('${car.name}', style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                ),
                ListTile(
                  title: Text('Giá',style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: Text('${car.price}', style: TextStyle(color: Colors.grey[800], fontSize: 16)),
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
                Divider(height: 5),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Mô tả",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.left,),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
