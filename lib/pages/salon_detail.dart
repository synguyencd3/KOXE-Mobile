import 'dart:async';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/model/salon_model.dart';

class SalonDetail extends StatefulWidget {
  const SalonDetail({super.key});

  @override
  State<SalonDetail> createState() => _SalonDetailState();
}

class _SalonDetailState extends State<SalonDetail> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const LatLng sourceLocation = LatLng(37.33500926, -122.03271288);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);
  
  Salon salon = new Salon();
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      initSalon();
    });
    super.initState();
  }

  void initSalon(){
     var data = ModalRoute.of(context)!.settings.arguments as Map;
    setState(() {
      salon=data['salon'];
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("${salon.name}"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            CarouselSlider(
                options: CarouselOptions(height: 200.0),
                items: salon.banner?.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                          color: Colors.amber
                        ),
                        child: Image.network(i)
                      );
                    },
                  );
                }).toList(),
              ),
        
            Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Thông tin liên hệ",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.left,),
                  ),
                ),
             Divider(height: 5),
        
            Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(children: [
              ListTile(
                    title: Text('Số điện thoại', style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text('${salon.phoneNumber}', style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
               ListTile(
                    title: Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${salon.address}', style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),
               ListTile(
                    title: Text('Địa chỉ', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${salon.address}', style: TextStyle(color: Colors.grey[800], fontSize: 16)),
                  ),  
        
            Divider(height: 5),      
            Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Giới thiệu",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.left,),
                  ),
                ),
        
            MarkdownBody(
                data: 
                '''# Markdown
---
**Hello** World!''',
                selectable: true,
              ),
            ],)),
        
          Divider(height: 5,),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 200,
                child: const GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: CameraPosition(
                    target: sourceLocation,
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    
    );
  }

}