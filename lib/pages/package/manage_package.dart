import 'package:flutter/material.dart';
import 'package:mobile/pages/login.dart';
import 'package:mobile/widgets/button.dart';

import '../../model/package_model.dart';
import '../../widgets/package_card.dart';

class ManagePackage extends StatefulWidget {
  const ManagePackage({super.key});

  @override
  State<ManagePackage> createState() => _ManagePackageState();
}

class _ManagePackageState extends State<ManagePackage> {
  final List<PackageModel> packages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Quản lý gói'),
        ),
        body: packages.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Không có gói nào'),
                  ],
                ),
              )
            : ListView.builder(itemBuilder: (context, index) {
                return PackageCard(package: packages[index]);
              }));
  }
}
