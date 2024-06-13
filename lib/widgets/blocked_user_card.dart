import 'package:flutter/material.dart';
import 'package:mobile/model/user_post_model.dart';
import 'package:mobile/services/salon_service.dart';

class BlockedUserCard extends StatefulWidget {
  UserPostModel userPostModel;

  BlockedUserCard({super.key, required this.userPostModel});

  @override
  State<BlockedUserCard> createState() => _BlockedUserCardState();
}

class _BlockedUserCardState extends State<BlockedUserCard> {
  bool isShowCard = true;

  Future<bool> unblockUser() async {
    print(widget.userPostModel.userId);
    bool response =
        await SalonsService.UnBlockUser(widget.userPostModel.userId);

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return isShowCard
        ? Card(
            child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text(widget.userPostModel.fullname),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  bool response = await unblockUser();
                  if (response) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Hoa tiêu đã được bỏ chặn')));
                    setState(() {
                      isShowCard = false;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Bỏ chặn hoa tiêu thất bại')));
                  }
                },
              ),
            ),
          ))
        : Container();
  }
}
