import 'package:flutter/material.dart';
import 'package:mobile/main.dart';

class ChatUserCard extends StatefulWidget {
  //final ChatUserModel user;
  const ChatUserCard({super.key});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
        elevation: 0.5,
        child: InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text('Demo User'),
          subtitle: Text('Last message from user',maxLines: 1,),
          trailing: Text('12:00 PM'),
          onTap: () {
            Navigator.pushNamed(context, '/chat');
          }
        ),
      ),
    ));
  }
}
