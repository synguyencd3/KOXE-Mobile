import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/car_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

//import 'package:panorama/panorama.dart';
import 'package:mobile/model/chat_user_model.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/widgets/button.dart';
import 'package:mobile/services/cars_service.dart';

import '../loading.dart';
import 'package:mobile/utils/utils.dart';
import 'package:mobile/utils/utils.dart';

class CarDetail extends StatefulWidget {
  @override
  State<CarDetail> createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  Car car = Car();
  Set<String> permission = {};

  // late final PageController pageController;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      initCar();
      getPermission();
    });
    super.initState();
  }

  void getPermission() async {
    var data = await SalonsService.getPermission();
    setState(() {
      permission = data;
    });
  }

  void initCar() async {
    //var data = ModalRoute.of(context)!.settings.arguments as Map;
    var arg = ModalRoute.of(context)!.settings.arguments as Map;
    var data = await CarsService.getDetail(arg['id']);
    setState(() {
      car = data!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(car.name ?? ''),
      ),
      body: car.id == null
          ? Loading()
          : SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                        height: 200.0,
                        aspectRatio: 2.0,
                        enableInfiniteScroll: false,
                        autoPlay: true),
                    items: car.image != null
                        ? car.image!.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration:
                                        BoxDecoration(color: Colors.amber),
                                    child: Image.network(
                                      i ??
                                          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.meadowbrookventuresinc.com%2Fvehicle%2F2007-chevrolet-impala-5547%2F&psig=AOvVaw1F85gFMkxnOc3ZhOCqGg-Y&ust=1716219588856000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCLDtmauGmoYDFQAAAAAdAAAAABAE',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 200.0,
                                    ));
                              },
                            );
                          }).toList()
                        : [],
                  ),
                  Text(
                    '${car.name}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Text(
                    '${formatCurrency(car.price!)}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Thông tin chi tiết",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
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
                          trailing: Text(
                              car.origin != ''
                                  ? '${car.origin}'
                                  : 'Chưa cập nhật',
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 16)),
                        ),
                        ListTile(
                          title: Text('Nhãn hiệu',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Text(
                              car.brand != ''
                                  ? '${car.brand}'
                                  : 'Chưa cập nhật',
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 16)),
                        ),
                        ListTile(
                          title: Text('Dòng xe',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Text('${car.type}',
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 16)),
                        ),
                        ListTile(
                          title: Text('Mẫu xe',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Text(
                              car.model != null
                                  ? '${car.model}'
                                  : 'Chưa cập nhật',
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 16)),
                        ),
                        ListTile(
                          title: Text('Số chỗ ngồi',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Text(
                              car.capacity != null
                                  ? '${car.capacity}'
                                  : 'Chưa cập nhật',
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 16)),
                        ),
                        ListTile(
                          title: Text('Số cửa',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Text(
                              car.door != null
                                  ? '${car.door}'
                                  : 'Chưa cập nhật',
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 16)),
                        ),
                        ListTile(
                          title: Text('Số kilometer đã đi',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Text(
                              car.kilometer != null
                                  ? '${car.kilometer}'
                                  : 'Chưa cập nhật',
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 16)),
                        ),
                        ListTile(
                          title: Text('Hộp số',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Text(
                              car.gear != null
                                  ? '${car.gear}'
                                  : 'Chưa cập nhật',
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 16)),
                        ),
                        ListTile(
                          title: Text('Ngày sản xuất',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Text(
                              car.mfg != null ? '${formatDate(DateTime.parse(car.mfg ?? ''))}' : 'Chưa cập nhật',
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 16)),
                        ),
                        ListTile(
                          title: Text('Màu ngoại thất',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Text(
                              car.outColor != ''
                                  ? '${car.outColor}'
                                  : 'Chưa cập nhật',
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 16)),
                        ),
                        Divider(height: 5),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mô tả",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  car.description != null
                                      ? '${car.description}'
                                      : 'Chưa cập nhật',
                                  style: TextStyle(
                                      color: Colors.grey[800], fontSize: 16),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Đang có tại",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Card(
                                  child: ListTile(
                                    title: Text('${car.salon?.name}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    subtitle: Text('${car.salon?.address}',
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 16)),
                                  ),
                                ),
                                car.warranty == null
                                    ? SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Gói bảo hành",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          Card(
                                            child: ListTile(
                                              title: Text(
                                                  '${car.warranty?.name}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Text(
                                                  '${car.warranty?.policy}',
                                                  style: TextStyle(
                                                      color: Colors.grey[800],
                                                      fontSize: 16)),
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        permission.contains("OWNER") ||
                                permission.contains("R_CAR")
                            ? Container()
                            : ButtonCustom(
                                onPressed: () async {
                                  print(car.id);
                                  Car? carDetail =
                                      await CarsService.getDetail(car.id ?? '');
                                  print(carDetail?.salon?.salonId ?? '');
                                  ChatUserModel user = ChatUserModel(
                                      id: carDetail?.salon?.salonId ?? '',
                                      name: carDetail?.salon?.name ?? '',
                                      carId: car.id);
                                  Navigator.pushNamed(
                                      context, '/create_appointment',
                                      arguments: user);
                                },
                                title: 'Đặt lịch hẹn để xem xe này',
                              ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
