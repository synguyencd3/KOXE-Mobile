import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/widgets/notification_card.dart';
import 'package:mobile/model/notification_model.dart';
import 'package:mobile/services/notification_service.dart';
import 'package:mobile/services/salon_service.dart';

import '../socket/socket_manager.dart';

class Noti extends StatefulWidget {
  @override
  State<Noti> createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  final List<NotificationModel> notifications = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getNotifications();
    });

  }
  Future<void> getNotifications() async {
    List<NotificationModel> notificationsArgument = ModalRoute.of(context)!.settings.arguments as List<NotificationModel>;
    if (notificationsArgument.isNotEmpty) {
      setState(() {
        notifications.addAll(notificationsArgument);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Thông báo'),
          backgroundColor: Colors.lightBlue,
        ),
        body: StreamBuilder<Object>(
          stream: SocketManager().notificationStream,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              {
                getNotifications();
              }
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return NotificationCard(notification: notifications[index]);
              },
            );
          }
        ));
  }
}
