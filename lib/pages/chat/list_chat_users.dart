import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/widgets/chat_user_card.dart';
import 'package:mobile/model/chat_user_model.dart';
import 'package:mobile/services/chat_service.dart';
import 'package:mobile/pages/loading.dart';
import 'package:mobile/socket/socket_manager.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  late List<ChatUserModel> users = [];

  StreamSubscription? _messageStreamSubscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUsers();

    _messageStreamSubscription = SocketManager().messageStream.listen((event) {
      print('Received event: $event');
      getAllUsers();
    });

  }
  @override
  void dispose() {
    _messageStreamSubscription?.cancel();
    super.dispose();
  }

  Future<void> getAllUsers() async {
    List<ChatUserModel> usersAPI = await ChatService.getAllChatedUsers();
    setState(() {
      users = usersAPI;
    });
  }

  @override
  Widget build(BuildContext context) {
    return users.isNotEmpty
        ?
             ListView.builder(
                itemCount: users.length,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: 1),
                itemBuilder: (context, index) {
                  return ChatUserCard(user: users[index]);
                },
              )

        :  Center(child: Text('Không có tin nhắn nào'));
  }
}
