import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/pages/loading.dart';


import '../../model/warranty_model.dart';
import '../../services/warranty_service.dart';

class WarrantyList extends StatefulWidget {
  const WarrantyList({Key? key}) : super(key: key);
  @override
  State<WarrantyList> createState() => _WarrantyState();
}

class _WarrantyState extends State<WarrantyList> {
  List<Warranty> warranties = [];
  bool isCalling = false;
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
      isCalling = true;
    });
  }

  Future<void> deleteWarranty(String id) async {
    WarrantyService.DeleteWarranty(id).then((value) {getWarrantiess();});
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
              Navigator.pushNamed(context, '/warranty_form').then((value) {getWarrantiess();});
            }, child: Text('Add Warranty')),
            Expanded(
                child: warranties.isEmpty && !isCalling ? Loading(): ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: warranties.length,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(10),
                          child: WarrantyCard(warranty: warranties[index], delete: deleteWarranty,));
                    })),
          ],
        ));
  }
}

class WarrantyCard extends StatelessWidget {
  const WarrantyCard({super.key, required this.warranty, required this.delete});
  final Warranty warranty;

  final Function delete;

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
                  child: Text('${warranty.policy}')),

              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(onPressed: () {
                      Navigator.pushNamed(context, '/warranty_form', arguments: {'warranty': warranty});
                    }, child: Text('Edit')),
                    OutlinedButton(onPressed: () {
                      delete(warranty.warrantyId);
                    }, child: Text('Delete')),
                  ],),
              )
            ],
                ),
          ),
      ),
    );
  }
}
