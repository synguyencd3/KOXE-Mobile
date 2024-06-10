import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/model/car_model.dart';

import '../../services/cars_service.dart';
import '../loading.dart';

class CarsListing extends StatefulWidget {
  const CarsListing({Key? key}) : super(key: key);
  @override
  State<CarsListing> createState() => _CarState();
}

class _CarState extends State<CarsListing> {
  List<Car> cars = [];
  bool isCalling = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getCars();
    });
  }
  Future<void> getCars() async {
    List<Car> list = ModalRoute.of(context)!.settings.arguments as List<Car>;
    setState(() {
      cars = list;
      isCalling =true;
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
           TextButton.icon(onPressed: () {Navigator.pushNamed(context, '/new_car');}, icon: Icon(Icons.add), label:Text('Thêm xe')),
            Expanded(
                child:cars.isEmpty && !isCalling ? Loading(): ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: cars.length,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CarCard(car: cars[index], getCars: getCars,),
                        ],
                      );
                    }))
          ],
        ));
  }
}

class CarCard extends StatelessWidget {
  final Car car;
  final Function getCars;
  CarCard({required this.car, required this.getCars});

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
                child:
                (car.image != null && car.image!.isNotEmpty && car.image![0] != "null")
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
                'Mô tả: ${car.description}',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Giá: ${car.price}',
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            CarsService.DeleteCar(car.id!).then((value) => {
                              if (value==true) Navigator.pop(context)
                            });
                          }, icon: Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/new_car', arguments: {'car':car}).then((value) => getCars);
                          }, icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/car_detail',
                                arguments: {'car': car ,'id': car.id});
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
