import 'dart:async';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/config.dart';
import 'package:mobile/model/chat_user_model.dart';
import 'package:mobile/model/salon_model.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:google_geocoding_api/src/utils/pretty_address_mapper.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/widgets/button.dart';
import '../../model/car_model.dart';
import 'package:mobile/widgets/car_card.dart';
import 'package:mobile/pages/loading.dart';

class SalonDetail extends StatefulWidget {
  const SalonDetail({super.key});

  @override
  State<SalonDetail> createState() => _SalonDetailState();
}

class _SalonDetailState extends State<SalonDetail> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng sourceLocation = new LatLng(0, 0);
  List<Marker> markers = <Marker>[];

  Salon salon = new Salon();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      initSalon();
      initCar();
      initMap().then(
        (value) {
          moveCamera();
        },
      );
    });
  }

  Future<void> moveCamera() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: sourceLocation, zoom: 17)));
  }

  Future<void> initMap() async {
    try {
      const String googelApiKey = Config.geocoding_api;
      final bool isDebugMode = true;
      final api = GoogleGeocodingApi(googelApiKey, isLogged: isDebugMode);
      final searchResults = await api.search(
        '${salon.address}',
        language: 'en',
      );
      final prettyAddress = searchResults.results.firstOrNull?.mapToPretty();
      setState(() {
        sourceLocation =
            LatLng(prettyAddress!.latitude, prettyAddress.longitude);

        markers.add(Marker(
            markerId: MarkerId('Salon'),
            position: sourceLocation,
            infoWindow: InfoWindow(title: '${salon.name}')));
      });
    } catch (e) {
      print('Google Geocoding Exception: $e');
      // Return a default value or handle the error as needed
    }
  }

  void initSalon() {
    var data = ModalRoute.of(context)!.settings.arguments as Map;
    setState(() {
      salon = data['salon'];
    });
  }

  Future<void> initCar() async {
    print(salon.salonId);
    List<Car>? data = await SalonsService.getDetail(salon.salonId ?? '');
    setState(() {
      salon.cars = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${salon.name}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(height: 200.0),
              items: salon.banner != null
                  ? salon.banner!.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(color: Colors.amber),
                              child: Image.network(i));
                        },
                      );
                    }).toList()
                  : [],
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Thông tin liên hệ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Divider(height: 5),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Số điện thoại',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Text('${salon.phoneNumber}',
                          style:
                              TextStyle(color: Colors.grey[800], fontSize: 16)),
                    ),
                    ListTile(
                      title: Text('Email',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${salon.email}',
                          style:
                              TextStyle(color: Colors.grey[800], fontSize: 16)),
                    ),
                    ListTile(
                      title: Text('Địa chỉ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${salon.address}',
                          style:
                              TextStyle(color: Colors.grey[800], fontSize: 16)),
                    ),
                    ButtonCustom(
                      onPressed: () {
                        //print(salon.userId);
                        ChatUserModel chatUser = ChatUserModel(
                            id: salon.salonId ?? '',
                            name: salon.name ?? '',
                            image: salon.image);
                        Navigator.pushNamed(context, '/chat',
                            arguments: chatUser);
                      },
                      title: 'Nhắn tin với salon ngay',
                    ),
                    SizedBox(height: 10),
                    Divider(height: 5),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Giới thiệu",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    MarkdownBody(
                      data: salon.introductionMarkdown ?? "",
                      selectable: true,
                    ),
                  ],
                )),
            Divider(
              height: 5,
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Xe của salon",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            salon.cars?[0]!= null ? CarCard(car: salon.cars![0]) : Loading(),
            TextButton.icon(
              onPressed: () {
                print(salon.cars?.length);
                Navigator.pushNamed(context, '/listing/manage', arguments: salon.cars);
              },
              label: Text('Xem tất cả'),
              icon: Icon(Icons.arrow_forward),
            ),
            Divider(height: 5),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: 200,
                child: GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: Set<Marker>.of(markers),
                  mapType: MapType.hybrid,
                  initialCameraPosition: CameraPosition(
                    target: sourceLocation,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
