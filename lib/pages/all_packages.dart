import 'package:flutter/material.dart';
import 'package:mobile/model/package_model.dart';

class AllPackages extends StatefulWidget {
  const AllPackages({super.key});

  @override
  State<AllPackages> createState() => _AllPackagesState();
}

class _AllPackagesState extends State<AllPackages> {
List<PackageModel> packages = [
    PackageModel(
      id: 1,
      name: 'Gói 1',
      description: 'Mô tả',
      price: 1000000,
      type: 'VIP',
    ),
    PackageModel(
      id: 2,
      name: 'Gói 2',
      description: 'Mô tả',
      price: 2000000,
      type: 'Normal',
    ),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gói dịch vụ'),
      ),
      body: Padding(
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
                    (e) => Card(
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
                            Text(e.description),
                            Text('Giá: ${e.price}'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/buy_package');
                              },
                              child: Text('Mua'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}


