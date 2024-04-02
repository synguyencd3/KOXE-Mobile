import 'package:flutter/material.dart';
import 'package:mobile/model/notification_model.dart';
import 'package:mobile/services/notification_service.dart';
import 'package:mobile/services/salon_service.dart';

class NotificationCard extends StatefulWidget {
  final NotificationModel notification;
  const NotificationCard({super.key, required this.notification});

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.notification.isRead ? Colors.white : Colors.grey[200],
        margin: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: widget.notification.image != null && widget.notification.image != ''
                      ? Image.network(widget.notification.image!)
                      : FittedBox(
                    child: Icon(Icons.notifications),
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(widget.notification.description, maxLines: 3, style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(widget.notification.createAt,maxLines: 1,style: TextStyle(fontSize: 12),),
                onTap: () async {
                  await NotificationService.markAsRead(widget.notification.id);
                  String salonId = await SalonsService.isSalon();
                  if (salonId == '')
                    {
                      setState(() {
                        widget.notification.isRead = true;
                      });
                    }
                }
            ),
          ),
        );;
  }
}
