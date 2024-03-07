import 'package:flutter/material.dart';
import 'package:mobile/model/car.dart';
import 'package:mobile/widgets/car_card.dart';

class IntroCar extends StatefulWidget {
  const IntroCar({Key? key}) : super(key: key);
  @override
  State<IntroCar> createState() => _CarState();
}

class _CarState extends State<IntroCar> {
  List<Car> cars = [
    Car(
        id: 1,
        name: 'Toyota',
        description: 'Camry',
        image: 'assets/1.png',
        price: 20000000),
    Car(
        id: 2,
        name: 'Toyota',
        description: 'Camry',
        image: 'assets/1.png',
        price: 20000000),
    Car(
        id: 2,
        name: 'Toyota',
        description: 'Camry',
        image: 'assets/1.png',
        price: 20000000)
  ];
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
