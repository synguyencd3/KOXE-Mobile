import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/model/car_model.dart';
import 'package:mobile/services/salon_service.dart';

import '../../services/cars_service.dart';
import '../loading.dart';
import 'package:mobile/utils/utils.dart';

class CarsListing extends StatefulWidget {
  const CarsListing({Key? key}) : super(key: key);

  @override
  State<CarsListing> createState() => _CarState();
}

class _CarState extends State<CarsListing> {
  List<Car> cars = [];
  bool isCalling = false;
  Set<String> permission = {};

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getCars();
      getPermission();
    });
  }

  void getPermission() async {
    var data = await SalonsService.getPermission();
    setState(() {
      permission = data;
    });
  }

  Future<void> getCars() async {
    var carsAPI =  await CarsService.getCarsOfSalon();
    setState(() {
      cars = carsAPI;
      isCalling = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          //automaticallyImplyLeading: false,
          title: Text(
            'Xe của salon',
            //   style: FlutterFlowTheme.of(context).titleLarge,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            permission.contains("OWNER") || permission.contains("C_CAR")
                ? TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/new_car');
                    },
                    icon: Icon(Icons.add),
                    label: Text('Thêm xe'))
                : Container(),
            permission.contains("OWNER") || permission.contains("R_CAR")
                ? Expanded(
                    child: cars.isEmpty && !isCalling
                        ? Loading()
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: cars.length,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  CarCard(
                                    car: cars[index],
                                    getCars: getCars,
                                    permission: permission,
                                  ),
                                ],
                              );
                            }))
                : Container()
          ],
        ));
  }
}

class CarCard extends StatelessWidget {
  final Car car;
  final Function getCars;
  final Set<String> permission;

  CarCard({required this.car, required this.getCars, required this.permission});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
                child: (car.image != null &&
                        car.image!.isNotEmpty &&
                        car.image![0] != "null")
                    ? Image.network(
                        car.image![0],
                        height: 230,
                        width: double.infinity,
                      )
                    : Image.asset("assets/placeholder-single.png"),
              ),
              SizedBox(height: 10),
              Text(
                'Tên xe: ${car.name}',
              ),
              SizedBox(height: 10),
              Text(
                car.description != null ? ('Mô tả: ${car.description}') : ('Mô tả: Chưa có mô tả'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Giá: ${formatCurrency(car.price!)}',
                  ),
                  Row(
                    children: [
                      permission.contains("OWNER") ||
                              permission.contains("D_CAR")
                          ? IconButton(
                              onPressed: () {
                                CarsService.DeleteCar(car.id!).then((value) => {
                                      if (value == true) Navigator.pop(context)
                                    });
                              },
                              icon: Icon(Icons.delete))
                          : Container(),
                      permission.contains("OWNER") ||
                              permission.contains("U_CAR")
                          ? IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/new_car',
                                        arguments: {'car': car})
                                    .then((value) => getCars);
                              },
                              icon: Icon(Icons.edit))
                          : Container(),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/car_detail',
                                arguments: {'car': car, 'id': car.id});
                          },
                          icon: Icon(Icons.arrow_forward)),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
