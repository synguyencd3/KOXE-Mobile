import 'package:flutter/material.dart';
import 'package:mobile/model/connection_model.dart';

import '../services/connection_service.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/utils/utils.dart';

class ConnectionCard extends StatefulWidget {
  final String connectionId;
  bool isShow;
  ConnectionCard({super.key, required this.connectionId, this.isShow=true});

  @override
  State<ConnectionCard> createState() => _ConnectionCardState();
}

class _ConnectionCardState extends State<ConnectionCard> {
  Future<bool> updateStatusConnection(String status) async {
    bool response = await ConnectionService.updateStatusConnection(
        status, widget.connectionId ?? '');
    return response;
  }

  String salonId = '';
  ConnectionModel connection = ConnectionModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getSalon();
      getConnectionDetail();
    });
  }

  Future<void> getSalon() async {
    String? salonIdAPI = await SalonsService.isSalon();
    setState(() {
      salonId = salonIdAPI;
    });
  }

  Future<void> getConnectionDetail() async {
    ConnectionModel connectionAPI =
        await ConnectionService.getConnectionDetail(widget.connectionId);
    setState(() {
      connection = connectionAPI;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(connection.salon?.name ?? ''),
                leading: Icon(Icons.store),
              ),
              ListTile(
                title: Text(connection.createAt ?? ''),
                leading: Icon(Icons.calendar_today_rounded),
              ),
              ListTile(
                title: Text(connection.processData?.name ?? ''),
                leading: Icon(Icons.car_repair),
              ),
              Column(
                children: connection.processData?.stages?.map((stage) {
                      return ListTile(
                        title: Text(stage.name ?? ''),
                        // Add more properties as needed
                      );
                    }).toList() ??
                    [], // Use an empty list if stages is null
              ),
              ListTile(
                title: Text(
                  connection.status == 'pending'
                      ? 'Chưa chấp nhận'
                      : connection.status == 'accepted'
                          ? 'Đã chấp nhận'
                          : 'Bị từ chối',
                  style: TextStyle(
                      color: connection.status == 'pending'
                          ? Colors.yellow[900]
                          : connection.status == 'accepted'
                              ? Colors.green
                              : Colors.red),
                ),
                leading: Icon(Icons.check_circle),
              ),
              (connection.status == 'pending' &&
                      salonId == '' ) ? widget.isShow == true ?
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FilledButton.icon(
                          onPressed: () async {
                            bool response =
                                await updateStatusConnection('accepted');
                            if (response) {
                              setState(() {
                                connection.status = 'accepted';
                              });
                            }
                          },
                          icon: Icon(Icons.check_circle),
                          label: Text('Đồng ý'),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.green)),
                        ),
                        FilledButton.icon(
                          onPressed: () async {
                            bool response =
                                await updateStatusConnection('rejected');
                            if (response) {
                              setState(() {
                                connection.status = 'rejected';
                              });
                            }
                          },
                          label: Text('Từ chối'),
                          icon: Icon(Icons.do_not_disturb_on_rounded),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red)),
                        ),
                      ],
                    )
                  : TextButton(child: Text('Đến trang quản lý kết nối'),onPressed: (){
                    Navigator.pushNamed(context,  '/connection');
              },): Container(),
            ],
          ),
        ),
      ),
    );
  }
}
