import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/salon_service.dart';


import '../model/articles_model.dart';
import '../model/salon_model.dart';

class SalonList extends StatefulWidget {
  const SalonList({super.key});

  @override
  State<SalonList> createState() => _SalonListState();
}

class _SalonListState extends State<SalonList> {
  List<Salon> salons = [];
  @override
  void initState() {
    super.initState();
    getSalons(); 
  }

  Future<void> getSalons() async {
    var list = await SalonsService.getAll();
    print(list);
    setState(() {
      salons = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        title: Text(
          'Salons',
          style: FlutterFlowTheme.of(context).titleLarge,
        ),
      ),
      body: ListView.builder(
          itemCount: salons.length,
          itemBuilder: (context, index) {
            return SalonCard(
                salon: salons[index]);
          }),
    );
  }
}


class SalonCard extends StatelessWidget {
  const SalonCard(
      {super.key,
      required this.salon});

  final Salon salon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/salon_detail', arguments: {'salon': salon});
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4,
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
        ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(child: Image.network(salon.image!),
                borderRadius: BorderRadius.circular(8),),
              ),
              Align(
                alignment: AlignmentDirectional(-1, 0),
                child: Column(
                  children: [Text(salon.name!, style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                    SizedBox(height: 3),
                   Padding(
                     padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                     child: Text(salon.address!)
                )],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

