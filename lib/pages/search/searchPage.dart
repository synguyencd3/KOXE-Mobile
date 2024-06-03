import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/pages/salon/salon_list.dart';
import 'package:mobile/widgets/car_card.dart';

import '../../services/cars_service.dart';
import '../../services/salon_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchValue = '';
  List<Widget> result = [];

  

  Future getCars(String search) async {
    var list = await CarsService.getAll(1, 999, search);
    setState(() {
      result.addAll(list.map((e) => CarCard(car: e)));
    });
  }

  Future<void> getSalons(String search) async {
    var list = await SalonsService.getAll(1, 999, search);
    setState(() {
      result.addAll(list.map((e) => SalonCard(salon: e)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: EasySearchBar(
                title: const Text('Tìm kiếm'),
                onSearch: (value) {
                  setState(() {
                    result=[];
                  });
                  EasyDebounce.debounce('my-debouncer',  Duration(seconds: 1), () {
                    if (value!="") {
                      print("searching for" + value);
                      getCars(value);
                      getSalons(value);
                    }
                    else {
                      setState(() {
                        result=[];
                      });
                    }
                  });
                },
                //suggestions: _suggestions,
              backgroundColor: Colors.lightBlue,
            ),
            body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: result,
                  ),
                )
            )
        );
  }
}