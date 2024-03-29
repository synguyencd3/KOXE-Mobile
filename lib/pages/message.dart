import 'package:flutter/material.dart';
import 'package:mobile/widgets/chat_user_card.dart';
class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}


class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 16,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: 1),
      itemBuilder: (context, index) {
        return const ChatUserCard();
      },
    );
  }
}
