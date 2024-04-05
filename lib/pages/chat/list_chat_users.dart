import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/widgets/chat_user_card.dart';
import 'package:mobile/model/chat_user_model.dart';
import 'package:mobile/services/chat_service.dart';
import 'package:mobile/model/chat_model.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/socket/socket_manager.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final List<ChatUserModel> users = [];
  final ChatModel lastMessage = ChatModel(
    sender: '1',
    receiver: '2',
    message: 'Hello',
    createdAt: '12:00 PM',
  );
  StreamSubscription? _messageSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUsers();
    _messageSubscription = SocketManager.messageStream.listen((data) {
      // Parse the message and create a types.Message object
    for (var user in users){
      if (user.id == data['senderId']){
        setState(() {
          user.lastMessage = data['message'];
          user.createdAt = data['createdAt'];
        });
        break;
      }
    }
    });
  }

  Future<void> getAllUsers() async {
    List<ChatUserModel> usersAPI = await ChatService.getAllChatedUsers();
    ChatModel lastMessageApi = ChatModel(
      sender: '1',
      receiver: '2',
      message: 'Hello',
      createdAt: '2024-04-05 09:57:00'
    );
    // add each userid from usersApi to function getMessages
    for (var user in usersAPI) {
     bool isGetMessage = await getMessages(user.id);
     if (isGetMessage)
       {
         user.lastMessage = lastMessage.message;
         user.createdAt = lastMessage.createdAt;
       }
     else
       {
         user.lastMessage = '';
         user.createdAt = '';
       }

    }
    setState(() {
      users.addAll(usersAPI);
    });
  }

  Future<bool> getMessages(String userId) async {
    List<ChatModel> chatAPI = await ChatService.getChatById(userId);
    if (chatAPI.isEmpty){
      return false;
    }
    setState(() {
      lastMessage.message = chatAPI.last.message;
      lastMessage.createdAt = chatAPI.last.createdAt;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: 1),
      itemBuilder: (context, index) {
        return ChatUserCard(user: users[index]);
      },
    );
  }
}
