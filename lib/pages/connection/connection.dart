import 'package:flutter/material.dart';
import 'package:mobile/widgets/connection_card.dart';

import '../../model/connection_model.dart';
import '../../services/connection_service.dart';
import 'package:mobile/pages/loading.dart';

class Connection extends StatefulWidget {
  const Connection({super.key});

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  List<ConnectionModel> connections = [];

  Future<void> getConnections() async {
    List<ConnectionModel> connectionsAPI =
        await ConnectionService.getConnections();
    connections = connectionsAPI;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý kết nối'),
      ),
      body: FutureBuilder(
          future: getConnections(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }
            return ListView.builder(
                itemCount: connections.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ConnectionCard(
                      connectionId: connections[index].id ?? '');
                });
          }),
    );
  }
}
