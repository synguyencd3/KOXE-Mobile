import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:mobile/model/car_model.dart';
import 'package:mobile/services/cars_service.dart';
import 'package:mobile/widgets/car_card.dart';

import '../pages/loading.dart';

class IntroCar extends StatefulWidget {
  const IntroCar({Key? key}) : super(key: key);
  @override
  State<IntroCar> createState() => _CarState();
}

class _CarState extends State<IntroCar> {
  List<Car> cars = [];
  bool isCalling = false;
  int index=1;
   @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getCars(index, 5);
      isCalling = true;
    });

  }
  Future getCars(int page, int perPage) async {
    var list = await CarsService.getAll(page, perPage);
    // if (mounted)
    //   {
        setState(() {
          if (list.length>0) index++;
          print(index);
          cars.addAll(list);
        });
      // }

  }

  @override
  Widget build(BuildContext context) {
    return cars.isEmpty && !isCalling ? Padding(
      padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
      child: Loading(),
     ) : //Column(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: cars.map((value) => CarCard(car: value)).toList(),
    // ),
    LazyLoadScrollView(
        scrollOffset: 200,
        child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: cars.length,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return CarCard(car: cars[index]);
        })
        , onEndOfPage: () => {getCars(index,5)}
    );
  }
}
