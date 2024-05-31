import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/services/package_service.dart';
import 'package:mobile/model/package_model.dart';
import 'package:mobile/services/salon_service.dart';

import '../model/salon_model.dart';
import '../services/payment_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>with SingleTickerProviderStateMixin {
  late PackageModel firstPackage = PackageModel(
    name: '',
    price: 400000,
    description: '',
    id: '',
    features: [],
  );
  late Salon firstSalon = Salon();
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late bool _isAnimationInitialized = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _isAnimationInitialized = true;
    getAllPackages();
    getAllSalons();

  }

  Future<void> getAllPackages() async {
    List<PackageModel> packages = await PackageService.getAllPackages();
    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        firstPackage = packages[0];
      });
    });
  }
  Future<void> getAllSalons() async {
    List<Salon> salons = await SalonsService.getAll();
    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        firstSalon = salons[0];
      });
    });
  }


  Widget build(BuildContext context) {
    return _isAnimationInitialized ? SlideTransition(
      position: _offsetAnimation,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NewsPadding(),
            SalonPadding(firstSalon: firstSalon,),
            SizedBox(height: 10),
            ServiceCard(
              package: firstPackage,
            ),
          ],
        ),
      ),
    ): Center(
      child: CircularProgressIndicator(),
    );
  }
}

class NewsPadding extends StatelessWidget {
  const NewsPadding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Khám phá',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text('Tin tức và khuyến mãi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 10),
              Image(
                image: AssetImage('assets/1.png'),
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                  'Mới đây, trên trang chủ của hãng VinFast, giá bán của hàng loạt mẫu ô tô điện đã có sự điều chỉnh. Tuy nhiên, thay vì giảm như một số hãng xe khác, VinFast lại tăng giá cho các mẫu ô tô điện của mình.'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/news');
                    },
                    label: Text('Xem tất cả', style:TextStyle(color: Colors.black)),
                    icon: Icon(Icons.arrow_forward, color:Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SalonPadding extends StatelessWidget {
  final Salon firstSalon;
  const SalonPadding({
    super.key,required this.firstSalon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Khám phá',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text('Các salon',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 10),
              Container(
                height: 200,
                width: double.infinity,
                child: Image(
                  image: NetworkImage(firstSalon.image ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text(firstSalon.name ?? '', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ListTile(
                title: Text(firstSalon.address ?? '', style: TextStyle(fontSize: 14),),
                leading: Icon(Icons.location_on),
              ),
              ListTile(
                title: Text(firstSalon.phoneNumber ?? '', style: TextStyle(fontSize: 14),),
                leading: Icon(Icons.phone),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/salons');
                    },
                    label: Text('Xem tất cả'),
                    icon: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceCard extends StatefulWidget {
  final PackageModel package;

  const ServiceCard({super.key, required this.package});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.package.features.length);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'Các gói dịch vụ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.topLeft,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    title: Text(
                      '${widget.package.name}',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Giá: ${widget.package.price}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/buy_package');
                      },
                      child: Text('Mua ngay'),
                    ),
                  ),
                  widget.package.features.length == 0
                  ? ListTile(
                    title: Text('Không có dịch vụ nào'),
                  ):
                  Column(
                    children: widget.package.features
                        .map((feature) => ListTile(
                              title: Text(feature.name),
                             leading: Icon(Icons.check),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pushNamed(context, '/packages');
              },
              child: Text('Xem tất cả'),
            ),
          ],
        ),
      ),
    );
  }
}
