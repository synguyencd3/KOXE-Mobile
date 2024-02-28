import 'package:mobile/widgets/car_card.dart';
import 'package:flutter/material.dart';
import 'package:mobile/modules/car.dart';

class CarCard extends StatefulWidget {
  final Car car;

  CarCard({required this.car});

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
              Image.asset(
                widget.car.image,
                height: 100,
                width: 100,
              ),
              SizedBox(height: 10),
              Text('Name: ${widget.car.name}'),
              SizedBox(height: 10),
              Text('Description: ${widget.car.description}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Price: ${widget.car.price}'),
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
