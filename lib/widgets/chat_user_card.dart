import 'package:flutter/material.dart';
import 'package:mobile/model/chat_user_model.dart';
import 'package:intl/intl.dart';
import 'package:mobile/services/salon_service.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUserModel user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
        color: widget.user.message?.status != null
            ? widget.user.message!.status
                ? Colors.white
                : Colors.grey[300]
            : Colors.white,
        elevation: 0.5,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(widget.user.image ??
                      'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'),
                ),
                title: Text(widget.user.name,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                subtitle: Text(
                  ((widget.user.message?.sender != '' ? widget.user.message!.sender + ': ' : ''))  + (widget.user.message?.message ?? ''),
                  maxLines: 1,
                ),
                trailing: Text(widget.user.message?.createdAt != null
                    ? widget.user.message!.createdAt
                    : ''),
                onTap: () async {
                  var result = await Navigator.pushNamed(context, '/chat',
                      arguments: widget.user);
                  if (result =='rebuild')
                    {
                      setState(() {
                        print('rebuild');
                        widget.user.message!.status = true;
                      });
                    }
                }),
          ),
        ));
  }
}
