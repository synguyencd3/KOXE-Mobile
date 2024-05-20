import 'package:flutter/material.dart';
import 'package:mobile/model/connection_model.dart';

import '../services/connection_service.dart';
import 'package:mobile/services/salon_service.dart';

class ConnectionCard extends StatefulWidget {
  ConnectionModel connection;

  ConnectionCard({super.key, required this.connection});

  @override
  State<ConnectionCard> createState() => _ConnectionCardState();
}

class _ConnectionCardState extends State<ConnectionCard> {
  Future<bool> updateStatusConnection(String status) async {
    bool response = await ConnectionService.updateStatusConnection(
        status, widget.connection.id ?? '');
    return response;
  }
  String salonId = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getSalon();
    });
  }

  Future<void> getSalon() async {
   String? salonIdAPI = await SalonsService.isSalon();
   setState(() {
     salonId = salonIdAPI;
   });

  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(widget.connection.salon?.name ?? ''),
              leading: Icon(Icons.store),
            ),
            ListTile(
              title: Text(widget.connection.createAt.toString()),
              leading: Icon(Icons.calendar_today_rounded),
            ),
            ListTile(
              title: Text(widget.connection.processData?.name ?? ''),
              leading: Icon(Icons.car_repair),
            ),
            Column(
              children: widget.connection.processData?.stages?.map((stage) {
                return ListTile(
                  title: Text(stage.name ?? ''),
                  // Add more properties as needed
                );
              }).toList() ?? [], // Use an empty list if stages is null
            ),
            ListTile(
              title: Text(
                widget.connection.status == 'pending'
                    ? 'Chưa chấp nhận'
                    : widget.connection.status == 'accepted'
                        ? 'Đã chấp nhận'
                        : 'Bị từ chối',
                style: TextStyle(
                    color: widget.connection.status == 'pending'
                        ? Colors.yellow[900]
                        : widget.connection.status == 'accepted'
                            ? Colors.green
                            : Colors.red),
              ),
              leading: Icon(Icons.check_circle),
            ),
             (widget.connection.status == 'pending' && salonId == '' )
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FilledButton(
                        onPressed: () async {
                          bool response =
                              await updateStatusConnection('accepted');
                          if (response) {
                            setState(() {
                              widget.connection.status = 'accepted';
                            });
                          }
                        },
                        child: Text('Đồng ý'),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green)),
                      ),
                      FilledButton(
                        onPressed: () async {
                          bool response =
                              await updateStatusConnection('rejected');
                          if (response) {
                            setState(() {
                              widget.connection.status = 'rejected';
                            });
                          }
                        },
                        child: Text('Từ chối'),
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
    );
  }
}
