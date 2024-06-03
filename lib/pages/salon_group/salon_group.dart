
import 'package:flutter/material.dart';

class SalonGroup extends StatefulWidget {
  const SalonGroup({super.key});

  @override
  State<SalonGroup> createState() => _SalonGroupState();
}

class _SalonGroupState extends State<SalonGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Các nhóm salon'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Nhóm salon $index'),
            onTap: () {
              Navigator.pushNamed(context, '/salon_group_detail');
            },
          );
        },
      ),
    );
  }
}
