import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
//import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mobile/config.dart';
import 'package:mobile/services/payment_service.dart';
import 'package:mobile/services/salon_service.dart';

import '../../model/salon_model.dart';
import '../loading.dart';

class SalonList extends StatefulWidget {
  const SalonList({super.key});

  @override
  State<SalonList> createState() => _SalonListState();
}

class _SalonListState extends State<SalonList> {
  List<Salon> salons = [];
  Set<String> keySet = Set();
  bool isCalling = false;
  int index =1;
  @override
  void initState() {
    super.initState();
    getSalons();
    getKeyMaps(); 
  }


  Future<void> getKeyMaps() async {
    var set = await PaymentService.getKeySet();
    print(set);
    setState(() {
      keySet = set;
    });
  }

  Future<void> getSalons() async {
    var list = await SalonsService.getAll(index, 5);
    print(list);
    setState(() {
      if (list.length>0) index++;
      salons.addAll(list);
      isCalling = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     //   backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        title: Text(
          'Salons',
        //  style: FlutterFlowTheme.of(context).titleLarge,
        ),
      ),
      body: Column(
        children: [
          keySet.contains(Config.SalonKeyMap) ?
          TextButton(onPressed: () { Navigator.pushNamed(context, '/my_salon').then((value) {getSalons();});}, child: const Text('Your salon')): const SizedBox(height: 20) ,
          Expanded(
            child: salons.isEmpty && !isCalling ? Loading() :LazyLoadScrollView(
              onEndOfPage: () { getSalons(); },
              child: ListView.builder(
                  itemCount: salons.length,
                  itemBuilder: (context, index) {
                    return SalonCard(
                        salon: salons[index]);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class MySalon extends StatefulWidget {
  const MySalon({super.key});

  @override
  State<MySalon> createState() => _MySalonState();
}

class _MySalonState extends State<MySalon> {

  Salon? MySalon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMySalon();
  }

  Future<void> deleteSalon(String id) async {
    SalonsService.DeleteSalon(id).then((value) {
      if (value!)
        {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Xóa thành thông'),
                backgroundColor: Colors.green,
              )
          );
          getMySalon();
          return;
        }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Có lỗi xảy ra, vui lòng thử lại sau'),
            backgroundColor: Colors.red,
          )
      );
    });
  }

  Future<void> getMySalon() async {
    var data = await SalonsService.getMySalon();
    print(data?.salonId);
    setState(() {
      MySalon = data;
    });
  }
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
        //  backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          title: Text(
            'Salons',
           // style: FlutterFlowTheme.of(context).titleLarge,
          ),
        ),
        body: Column(
          children: [
            MySalon !=null ?
            MySalonCard(salon: MySalon!,
            deletefunc: deleteSalon)
            
            :  TextButton(onPressed: () { Navigator.pushNamed(context, '/new_salon');}, child: const Text('Thêm mới')),
          ],
        ),
      );
    }
  }

class MySalonCard extends StatefulWidget {
   const MySalonCard(
      {super.key,
      required this.salon,
      required this.deletefunc});

  final Salon salon;
  final Function deletefunc;

  @override
  State<MySalonCard> createState() => _MySalonCardState();
}

class _MySalonCardState extends State<MySalonCard> {

  late Salon salon;

  Future<void> getMySalon() async {
    var data = await SalonsService.getMySalon();
    //print(data?.salonId);
    setState(() {
      salon = data!;
    });
  }

  void init(){
    salon =widget.salon;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }


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
                ),
                 Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          OutlinedButton(onPressed: () {
                            Navigator.pushNamed(context, '/new_salon', arguments: {'salon': salon}).then((value) {getMySalon();}).then((value)  {getMySalon();});
                            }, child: Text('Edit')),
                          OutlinedButton(onPressed: () {
                            widget.deletefunc(salon.salonId);
                          }, child: Text('Delete')),
                        ],),
                 )
                ],
                ),
              )
            ],
          ),
        ),
      ),
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
                child: ClipRRect(borderRadius: BorderRadius.circular(8),child: salon.image! == "null" || salon.image! == "" ? Image.asset("assets/house-placeholder.jpg") : Image.network(salon.image!),),
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

