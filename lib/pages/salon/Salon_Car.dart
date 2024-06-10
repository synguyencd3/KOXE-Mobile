import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/car_model.dart';
import '../../widgets/car_card.dart';
import '../loading.dart';

class SalonCar extends StatefulWidget {
  const SalonCar({Key? key, required this.salonCars}) : super(key: key);
  final List<Car> salonCars;
  @override
  State<SalonCar> createState() => _SalonCarState();
}

class _SalonCarState extends State<SalonCar> {
  List<Car> cars = [];
  bool isCalling = false;
  @override
  void initState() {
    super.initState();
    getCars();
  }
  Future<void> getCars() async {
    setState(() {
      cars = widget.salonCars;
      isCalling =true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Xe của salon',
            //   style: FlutterFlowTheme.of(context).titleLarge,
          ),
        ),
        body: Column(
          children: [
           Expanded(
                child:cars.isEmpty && !isCalling ? Loading(): ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: cars.length,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CarCard(car: cars[index]),
                        ],
                      );
                    }))
          ],
        ));
  }
}
