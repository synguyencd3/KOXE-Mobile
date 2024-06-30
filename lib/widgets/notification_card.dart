import 'package:flutter/material.dart';
import 'package:mobile/model/connection_model.dart';
import 'package:mobile/model/notification_model.dart';
import 'package:mobile/services/connection_service.dart';
import 'package:mobile/services/notification_service.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:intl/intl.dart';
import 'package:mobile/widgets/appointment_card.dart';
import 'package:mobile/services/appointment_service.dart';
import 'package:mobile/model/appointment_model.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/widgets/connection_card.dart';

class NotificationCard extends StatefulWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  String salonId = '';

  Future<void> getSalonId() async {
    String salonIdAPI = await SalonsService.isSalon();
    setState(() {
      salonId = salonIdAPI;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      getSalonId();
    });
    super.initState();
  }

  // 0: not yet, 1: accepted, 2: rejected
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: Card(
        color: !widget.notification.isRead
            ? Colors.white10
            : widget.notification.isAccepted == 1
                ? Colors.green[200]
                : widget.notification.isAccepted == 2
                    ? Colors.red[200]
                    : Colors.white,
        margin: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              ListTile(
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
                    if (salonId == '') {
                      await NotificationService.markAsRead(
                          widget.notification.id);
                      if (widget.notification.types == 'connection') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                                backgroundColor: Colors.transparent,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ConnectionCard(
                                      connectionId:
                                          widget.notification.data ?? '',
                                    ),
                                  ],
                                ));
                          },
                        );
                      }
                      setState(() {
                        widget.notification.isRead = true;
                      });
                    } else {
                      await NotificationService.markAsReadSalon(
                          widget.notification.id, salonId);
                      if (widget.notification.types == 'appointment') {
                        AppointmentModel appointment =
                            await AppointmentService.getAppointmentById(
                                salonId, widget.notification.data ?? '');
                        appointment.dayDiff = appointment.datetime
                                .difference(DateTime.now())
                                .inDays +
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
                      if (widget.notification.types == 'request') {
                        Navigator.pushNamed(context, '/post_detail',
                            arguments: widget.notification.data);
                      }
                      setState(() {
                        widget.notification.isRead = true;
                      });
                    }
                  }),
              ((widget.notification.types == 'request' && salonId != '') ||
                      (widget.notification.types == 'connection' &&
                          salonId == '') ||
                      (widget.notification.types == 'appointment' &&
                          salonId != ''))
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('Nhấp vào để xem chi tiết', style: TextStyle(fontStyle: FontStyle.italic)),
                      ))
                  : Container(),
              (widget.notification.types == 'invite' &&
                      widget.notification.isAccepted == 0)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FilledButton(
                          onPressed: () async {
                            bool check = await SalonsService.acceptInvite(
                                widget.notification.data ?? '');
                            if (check) {
                              await NotificationService.markAsRead(
                                  widget.notification.id);
                              setState(() {
                                widget.notification.isRead = true;
                                widget.notification.isAccepted = 1;
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Icon(Icons.check_circle),
                              SizedBox(width: 10),
                              Text('Chấp nhận'),
                            ],
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green)),
                        ),
                        FilledButton(
                          onPressed: () async {
                            await NotificationService.markAsRead(
                                widget.notification.id);
                            setState(() {
                              widget.notification.isRead = true;
                              widget.notification.isAccepted = 2;
                            });
                          },
                          child: Row(
                            children: [
                              Icon(Icons.do_not_disturb_on_rounded),
                              SizedBox(width: 10),
                              Text('Từ chối'),
                            ],
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red)),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
