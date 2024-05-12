
import 'package:flutter/material.dart';
import 'package:mobile/widgets/connection_card.dart';

import '../../model/connection_model.dart';
import '../../services/connection_service.dart';

class Connection extends StatefulWidget {
  const Connection({super.key});

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  List<ConnectionModel> connections = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getConnections();
    });
  }

  Future<void> getConnections() async {
    List<ConnectionModel> connectionsAPI = await ConnectionService.getConnections();
   setState(() {
      connections = connectionsAPI;
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connection'),
      ),
      body: ListView.builder(
          itemCount: connections.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ConnectionCard(connection: connections[index]);
          }),
    );
  }
}
