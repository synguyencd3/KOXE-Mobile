

import 'package:flutter/material.dart';
import 'package:mobile/model/user_search_model.dart';
import 'package:mobile/model/chat_user_model.dart';

class UserSearchCard extends StatelessWidget {
  final UserSearchModel userSearchModel;
  const UserSearchCard({super.key, required this.userSearchModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          ChatUserModel chatUserModel = ChatUserModel(
            id: userSearchModel.user_id!='' ? userSearchModel.user_id ?? '': userSearchModel.salon_id ?? '',
            name: userSearchModel.name,
          );
          Navigator.pushNamed(context, '/chat', arguments: chatUserModel);
        },
        leading: Icon(Icons.person_pin_rounded),
        title: Text(userSearchModel.name),
      ),
    );
  }
}
