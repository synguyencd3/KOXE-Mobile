import 'package:flutter/material.dart';
import 'package:mobile/model/chat_user_model.dart';
import 'package:intl/intl.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUserModel user;
  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    DateTime createdAt = DateTime.parse(widget.user.createdAt ?? '');
    String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(createdAt);
    return Card(
      margin: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
        elevation: 0.5,
        child: InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.user.image ?? 'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'),
          ),
          title: Text(widget.user.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          subtitle: Text(widget.user.lastMessage ?? '',maxLines: 1,),
          trailing: Text(formattedDate),
          onTap: () async{
            var result = await Navigator.pushNamed(context, '/chat', arguments: widget.user);
            if (result != null){
              setState(() {
                widget.user.lastMessage = result as String?;
              });
            }

          }
        ),
      ),
    ));
  }
}
