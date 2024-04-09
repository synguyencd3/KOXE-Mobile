import 'package:flutter/material.dart';
import 'package:mobile/model/notification_model.dart';
import 'package:mobile/services/notification_service.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:intl/intl.dart';
import 'package:mobile/widgets/appointment_card.dart';
import 'package:mobile/services/appointment_service.dart';
import 'package:mobile/model/appointment_model.dart';

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
              backgroundImage: widget.notification.avatar != ''
                  ? NetworkImage(widget.notification.avatar)
                  : NetworkImage(
                      'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'),
            ),
            title: Text(
              widget.notification.description ?? 'Thông báo',
              maxLines: 3,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy HH:mm')
                  .format(widget.notification.createAt),
              maxLines: 1,
              style: TextStyle(fontSize: 12),
            ),
            onTap: () async {
              String salonId = await SalonsService.isSalon();
              if (salonId == '') {
                await NotificationService.markAsRead(widget.notification.id);
                setState(() {
                  widget.notification.isRead = true;
                });
              } else {
                await NotificationService.markAsReadSalon(
                    widget.notification.id, salonId);
                setState(() {
                  widget.notification.isRead = true;
                });
                if (widget.notification.types == 'appointment') {
                  AppointmentModel appointment =
                      await AppointmentService.getAppointmentById(
                          salonId, widget.notification.appointmentId);
                  appointment.dayDiff =
                      appointment.datetime.difference(DateTime.now()).inDays +
                          1;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                          backgroundColor: Colors.transparent,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppointmentCard(
                                appointment: appointment,
                                isSalon: salonId,
                              ),
                            ],
                          ));
                    },
                  );
                }
              }
            }),
      ),
    );
    ;
  }
}
