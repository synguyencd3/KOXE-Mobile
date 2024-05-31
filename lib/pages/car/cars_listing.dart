import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:mobile/model/car_model.dart';
import 'package:mobile/services/cars_service.dart';
import 'package:mobile/services/salon_service.dart';

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
          children: [
            Align(
              alignment: Alignment.centerLeft,
                child: TextButton(onPressed: () {Navigator.pushNamed(context, '/new_car');}, child: Text('Thêm xe'))),
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
                          // Row(
                          //   children: [
                          //     TextButton(onPressed: () => { Navigator.pushNamed(context, '/new_car', arguments: {'car':cars[index]}).then((value) => getCars())}, child: Text('edit'))
                          //   ],
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          // )
                        ],
                      );
                    }))
          ],
        ));
  }
}

class CarCard extends StatefulWidget {
  final Car car;
  final Function getCars;
  CarCard({required this.car, required this.getCars});

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
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
                (widget.car.image != null && widget.car.image!.isNotEmpty && widget.car.image![0] != "null")
                    ? Image.network(
                  widget.car.image![0],
                  height: 230,
                  width: double.infinity,
                )
                    : Image.asset("assets/placeholder-single.png"),
              ),
              SizedBox(height: 10),
              Text(
                'Tên xe: ${widget.car.name}',
              ),
              SizedBox(height: 10),
              Text(
                'Mô tả: ${widget.car.description}',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Giá: ${widget.car.price?.toInt()}',
                  ),
                  Row(
                    children: [
                      // IconButton(
                      //     onPressed: () {
                      //       //Navigator.pushNamed(context, '/new_car', arguments: {'car':widget.car}).then((value) => widget.getCars);
                      //     }, icon: Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/new_car', arguments: {'car':widget.car}).then((value) => widget.getCars);
                          }, icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/car_detail',
                                arguments: {'car': widget.car ,'id': widget.car.id});
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
