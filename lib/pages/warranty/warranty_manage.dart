import 'package:flutter/material.dart';

class WarrantyManage extends StatefulWidget {
  const WarrantyManage({super.key});

  @override
  State<WarrantyManage> createState() => _WarrantyManageState();
}

class _WarrantyManageState extends State<WarrantyManage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warranty Manage'),
      ),
      body: Center(
        child: Text('Warranty Manage'),
      ),
    );
  }
}
