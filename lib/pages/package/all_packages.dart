import 'package:flutter/material.dart';
import 'package:mobile/model/package_model.dart';
import 'package:mobile/services/package_service.dart';
import 'package:mobile/services/payment_service.dart';

class AllPackages extends StatefulWidget {
  const AllPackages({super.key});

  @override
  State<AllPackages> createState() => _AllPackagesState();
}

class _AllPackagesState extends State<AllPackages> {
  List<PackageModel> packages = [];
  late Set<String> purchasedSet;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
    getPurchased().then((value) {
       getAllPackages();
    });
    });
  }

  Future<void> getPurchased() async {
    var set = await PaymentService.getPurchasedSet();
    
    setState(() {
      purchasedSet = set;
    });
  }

  Future<void> getAllPackages() async {
    try {
      List<PackageModel> packageAPI = await PackageService.getAllPackages();
      setState(() {
        packages = packageAPI.where((element) => !purchasedSet.contains(element.id)).toList();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gói dịch vụ'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Danh sách gói dịch vụ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Column(
                children: packages
                    .map(
                      (e) {
                        return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(e.name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue)),
                              Text('Giá: ${e.price}'),
                              const Text('Các tính năng:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ListView(
                                shrinkWrap: true,
                                children: e.features
                                    .map(
                                      (e) => ListTile(
                                        leading: Icon(Icons.check),
                                        title: Text(e.name),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                      ),
                                    )
                                    .toList(),
                              ),
                              Text(e.description),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/buy_package', arguments: {
                                    'package': e
                                  });
                                },
                                child: Text('Mua'),
                              ),
                            ],
                          ),
                        ),
                      );
                      },
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
