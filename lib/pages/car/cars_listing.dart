import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/model/car_model.dart';
//import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mobile/widgets/car_card.dart';

class CarsListing extends StatefulWidget {
  const CarsListing({Key? key}) : super(key: key);
  @override
  State<CarsListing> createState() => _CarState();
}

class _CarState extends State<CarsListing> {
  List<Car> cars = [];
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
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: cars.length,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CarCard(car: cars[index]);
                    }))
          ],
        ));
  }
}
