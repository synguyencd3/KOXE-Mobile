import 'package:flutter/material.dart';
import 'package:mobile/widgets/text_card.dart';

class Noti extends StatefulWidget {
  const Noti({super.key});

  @override
  State<Noti> createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông báo'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column()

    );
  }
}

