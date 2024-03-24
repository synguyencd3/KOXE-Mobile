import 'package:flutter/material.dart';
import 'package:mobile/model/appointment_model.dart';
import 'package:intl/intl.dart';

class AppointmentCard extends StatefulWidget {
  final AppointmentModel appointment;

  AppointmentCard({required this.appointment});

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    int daysDifference = DateTime.now().difference(DateTime.parse(widget.appointment.datetime)).inDays;
    DateTime appointmentDateTime = DateTime.parse(widget.appointment.datetime);
    String appointmentDate = '${appointmentDateTime.day}/${appointmentDateTime.month}/${appointmentDateTime.year}';
    String appointmentTime = '${appointmentDateTime.hour.toString().padLeft(2,'0')}:${appointmentDateTime.minute.toString().padLeft(2,'0')}';
    return Card(
        child: Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(10.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thời gian còn lại  $daysDifference ngày',
              style: TextStyle(fontWeight: FontWeight.w200),
            ),
            Text(widget.appointment.description,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ListTile(
              title: Text(appointmentDate) ,
              leading: Icon(Icons.calendar_today_rounded),
            ),
            ListTile(
              title: Text(appointmentTime),
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
              title: Text(widget.appointment.accepted
                  ? 'Đã xác nhận'
                  : 'Chưa xác nhận'),
              leading: Icon(Icons.check_circle),
            ),
            OutlinedButton(
                onPressed: () {},
                child: Text('Điều chỉnh lịch hẹn'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                )),
          ]),
    ));
  }
}
