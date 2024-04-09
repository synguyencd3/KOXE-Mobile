import 'package:flutter/material.dart';
import 'package:mobile/model/appointment_model.dart';
import 'package:mobile/services/appointment_service.dart';

class AppointmentCard extends StatefulWidget {
  final AppointmentModel appointment;
  final String isSalon;

  AppointmentCard({required this.appointment, required this.isSalon});

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  late bool showButton = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.appointment.datetime);
  }

  @override
  Widget build(BuildContext context) {
    DateTime appointmentDateTime = widget.appointment.datetime;
    String appointmentDate =
        '${appointmentDateTime.day}/${appointmentDateTime.month}/${appointmentDateTime.year}';
    String formattedHour = appointmentDateTime.hour.toString().padLeft(2, '0');
    String formattedMinute = appointmentDateTime.minute.toString().padLeft(2, '0');
    return Card(
        child: Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(10.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.appointment.dayDiff < 0
                ? Text(
                    'Lịch hẹn đã qua',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                : Text(
                    'Thời gian còn lại ${widget.appointment.dayDiff} ngày',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
            Text(widget.appointment.description ?? 'Không có mô tả',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ListTile(
              title: Text(appointmentDate),
              leading: Icon(Icons.calendar_today_rounded),
            ),
            ListTile(
              title: Text('$formattedHour:$formattedMinute'),
              leading: Icon(Icons.alarm_rounded),
            ),
            ListTile(
              title: Text(widget.appointment.salon),
              leading: Icon(Icons.location_pin),
            ),
            ListTile(
              title: Text('Số điện thoại'),
              leading: Icon(Icons.phone_rounded),
            ),
            ListTile(
              title: Text(
                widget.appointment.status == 0
                    ? 'Chưa chấp nhận'
                    : widget.appointment.status == 1
                        ? 'Đã chấp nhận'
                        : 'Bị từ chối',
                style: TextStyle(
                    color: widget.appointment.status == 0
                        ? Colors.yellow[900]
                        : widget.appointment.status == 1
                            ? Colors.green
                            : Colors.red),
              ),
              leading: Icon(Icons.check_circle),
            ),
            widget.isSalon == ''
                ? Container()
                : widget.appointment.status == 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FilledButton(
                            onPressed: () async {
                              bool check = await AppointmentService
                                  .updateSalonAppointment(
                                      widget.isSalon, widget.appointment.id, 1);
                              if (check) {
                                setState(() {
                                  widget.appointment.status = 1;
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
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green)),
                          ),
                          FilledButton(
                            onPressed: () async {
                              bool check = await AppointmentService
                                  .updateSalonAppointment(widget.isSalon,
                                      widget.appointment.id ?? '', 2);
                              if (check) {
                                setState(() {
                                  widget.appointment.status = 2;
                                });
                              }
                            },
                            child: Row(
                              children: [
                                Icon(Icons.check_circle),
                                SizedBox(width: 10),
                                Text('Từ chối'),
                              ],
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red)),
                          ),
                        ],
                      )
                    : Container(),
          ]),
    ));
  }
}
