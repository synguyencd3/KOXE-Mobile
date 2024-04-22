import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


import '../../model/warranty_model.dart';
import '../../services/warranty_service.dart';

class WarrantyList extends StatefulWidget {
  const WarrantyList({Key? key}) : super(key: key);
  @override
  State<WarrantyList> createState() => _WarrantyState();
}

class _WarrantyState extends State<WarrantyList> {
  List<Warranty> warranties = [];
  @override
  void initState() {
    super.initState();
    getWarrantiess();
  }
  Future<void> getWarrantiess() async {
   // List<Warranty> list = ModalRoute.of(context)!.settings.arguments as List<Warranty>;
    var list = await WarrantyService.getAll();
    //print(list);
    setState(() {
      warranties = list;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          //automaticallyImplyLeading: false,
          title: Text(
            'Gói bảo hành',
            //   style: FlutterFlowTheme.of(context).titleLarge,
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TextButton(onPressed: () {
              Navigator.pushNamed(context, '/warranty_form');
            }, child: Text('Add Warranty')),
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: warranties.length,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(10),
                          child: WarrantyCard(warranty: warranties[index]));
                    }))
          ],
        ));
  }
}

class WarrantyCard extends StatelessWidget {
  const WarrantyCard({super.key, required this.warranty});
  final Warranty warranty;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(padding: EdgeInsets.all(12),
          child: Align(
            alignment: AlignmentDirectional(-1, 0),
            child: Column(
            children: [
              Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Text(
                      '${warranty.name}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16))),
              Align(
                  alignment: AlignmentDirectional(-1,0),
                  child: Text('${warranty.limitKilometer} Km đầu tiên trong vòng ${warranty.months} tháng')),
              Align(
                alignment: AlignmentDirectional(-1,0),
                  child: Text('${warranty.policy}'))
            ],
                ),
          ),
      ),
    );
  }
}
