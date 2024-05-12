import 'package:flutter/material.dart';
import 'package:mobile/model/connection_model.dart';

class ConnectionCard extends StatefulWidget {
  ConnectionModel connection;

  ConnectionCard({super.key, required this.connection});

  @override
  State<ConnectionCard> createState() => _ConnectionCardState();
}

class _ConnectionCardState extends State<ConnectionCard> {
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
              title: Text(widget.connection.createAt.toString()),
              leading: Icon(Icons.calendar_today_rounded),
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
            Row(
              children: [
                FilledButton(
                  onPressed: () {},
                  child: Text('Đồng ý'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                ),
                FilledButton(
                  onPressed: () {},
                  child: Text('Từ chối'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
