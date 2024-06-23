import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/widgets/notification_card.dart';
import 'package:mobile/model/notification_model.dart';
import 'package:mobile/services/notification_service.dart';
import 'package:mobile/services/salon_service.dart';

import '../socket/socket_manager.dart';
import 'package:mobile/pages/loading.dart';

class Noti extends StatefulWidget {
  @override
  State<Noti> createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  late List<NotificationModel> notifications = [];
  StreamSubscription? _notificationSubscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notificationSubscription = SocketManager().notificationStream.listen((data) {
      getAllNotification();
    });

  }
  // Future<void> getNotifications() async {
  //   List<NotificationModel> notificationsArgument = ModalRoute.of(context)!.settings.arguments as List<NotificationModel>;
  //   if (notificationsArgument.isNotEmpty) {
  //     setState(() {
  //       notifications= notificationsArgument;
  //     });
  //   }
  // }
  Future<void> getAllNotification() async {
    String salonId = await SalonsService.isSalon();
    List<NotificationModel> notificationAPI = [];
    if (salonId == '') {
      notificationAPI = await NotificationService.getAllNotification();
    } else {
      notificationAPI =
      await NotificationService.getAllNotificationSalon(salonId);
    }
    notifications = notificationAPI;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Thông báo'),
          backgroundColor: Colors.lightBlue,
        ),
        body:
             FutureBuilder(
               future: getAllNotification(),
               builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                   return Loading();
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
