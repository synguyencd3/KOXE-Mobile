import 'package:flutter/material.dart';
import 'package:mobile/model/car_model.dart';
import 'package:mobile/services/cars_service.dart';
import 'package:mobile/widgets/car_card.dart';

class IntroCar extends StatefulWidget {
  const IntroCar({Key? key}) : super(key: key);
  @override
  State<IntroCar> createState() => _CarState();
}

class _CarState extends State<IntroCar> {
  List<Car> cars = [];

   @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getCars();
    });

  }
  Future<void> getCars() async {
    var list = await CarsService.getAll();
    if (mounted)
      {
        setState(() {
          cars = list;
        });
      }

  }

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 1;
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: cars.map((value) => CarCard(car: value)).toList(),
              ),
            ),
          ],
        ),
    );
  }
}
