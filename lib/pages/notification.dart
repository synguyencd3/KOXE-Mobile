import 'package:flutter/material.dart';
import 'package:mobile/widgets/notification_card.dart';
import 'package:mobile/model/notification_model.dart';

class Noti extends StatefulWidget {


  @override
  State<Noti> createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  final List<NotificationModel> notifications = [
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông báo'),
        backgroundColor: Colors.lightBlue,
      ),
      body: ListView.builder( physics: BouncingScrollPhysics(), itemCount:notifications.length,itemBuilder: (context, index) {
        return NotificationCard();
      },

    )
    );
  }
}

