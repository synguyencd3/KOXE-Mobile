import 'package:flutter/material.dart';
import 'package:mobile/model/user_post_model.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/widgets/blocked_user_card.dart';
import 'package:mobile/pages/loading.dart';

class BlockedUser extends StatefulWidget {
  const BlockedUser({super.key});

  @override
  State<BlockedUser> createState() => _BlockedUserState();
}

class _BlockedUserState extends State<BlockedUser> {
  List<UserPostModel> blockedUser = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> getBlockedUser() async {
    List<UserPostModel> usersAPI = await SalonsService.getBlockedUsers();
    blockedUser = usersAPI;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý hoa tiêu bị chặn'),
        backgroundColor: Colors.lightBlue,
      ),
      body: FutureBuilder(
          future: getBlockedUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }
            return blockedUser.isNotEmpty
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: blockedUser.length,
                    itemBuilder: (context, index) {
                      return BlockedUserCard(userPostModel: blockedUser[index]);
                    })
                : Center(child: Text('Không có hoa tiêu nào bị chặn'));
          }),
    );
  }
}
