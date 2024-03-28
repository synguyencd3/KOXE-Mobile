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
    int daysDifference = DateTime.parse(widget.appointment.datetime).difference(DateTime.now()).inDays;
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
            daysDifference < 0
                ? Text(
                    'Lịch hẹn đã qua',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                :
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
              title: Text(
                  widget.appointment.status == 0
                      ? 'Chưa chấp nhận'
                      : widget.appointment.status == 1
                          ? 'Đã chấp nhận'
                          : 'Bị từ chối',
                style: TextStyle(color: widget.appointment.status == 0
                    ? Colors.yellow[900]
                    : widget.appointment.status == 1
                    ? Colors.green
                    : Colors.red
                ),
              ),
              leading: Icon(Icons.check_circle),
            ),
            daysDifference< 0
                ? Container()
                :
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
