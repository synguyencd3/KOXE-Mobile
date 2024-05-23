import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/services/shared_service.dart';
import 'package:mobile/socket/socket_manager.dart';
import 'package:mobile/widgets/text_card.dart';
import 'package:mobile/services/api_service.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  Map<String, dynamic> userProfile = {};
  late TextEditingController controller;
  Set<String> permissions = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
    getUserProfile();
    getPermissions();
  }

  void getPermissions() async {
    var data = await SalonsService.getPermission();
    print(data);
    setState(() {
      permissions = data;
    });
}

  Future<void> getUserProfile() async {
    try {
      Map<String, dynamic> profile = await APIService.getUserProfile();
      //print(profile);
      setState(() {
        userProfile = profile;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Hàm submit dialog
    void submit()  async {
      Navigator.of(context).pop(controller.text);
      // giá trị đang được nhập sẽ là controller.text khi nhấn ok
      APIService.sendInvite(controller.text);
      controller.clear();
    }
    // Hàm mở popup dialog
    Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Mời bạn bè'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Nhập email bạn bè',
            ),
            controller: controller,
            onSubmitted: (_) => submit(),
          ),
          actions: [
            TextButton(onPressed: ()=>submit(), child: Text('OK')),
          ],
        ));
    return Column(
      children: [
        SizedBox(height: 20),
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(userProfile['avatar'] != null
                ? userProfile['avatar']
                : 'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'),
          ),
        ),
        SizedBox(height: 10),
        Text(
          userProfile['fullname'] ?? '',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        text_card(
            title: 'Thông tin cá nhân',
            icon: Icons.person,
            onTap: () async {
              Navigator.pushNamed(context, '/user_info',
                  arguments: userProfile);
              final result = await Navigator.pushNamed(context, '/user_info',
                  arguments: userProfile);
              if (result == 'update') {
                setState(() {
                  getUserProfile();
                });
              }
            }),
        text_card(
            title: 'Mời bạn bè',
            icon: Icons.person_add,
            onTap: openDialog,
        ),
        text_card(
            title: 'Cài đặt',
            icon: Icons.settings,
            onTap: () {
              Navigator.pushNamed(context, '/setting');
            }),
        permissions.length > 0 ?
        text_card(
            title: 'Quản lý',
            icon: Icons.manage_accounts,
            onTap: () {
              Navigator.pushNamed(context, '/manage');
            }) : Container(),
        text_card(
            title: 'Xe của tôi',
            icon: Icons.car_crash,
            onTap: () {
              Navigator.pushNamed(context, '/user_manage');
            }),
        text_card(
            title: 'Quản lý giao dịch hoa tiêu',
            icon: Icons.manage_accounts,
            onTap: () {
              Navigator.pushNamed(context, '/transaction');
            }),
        text_card(
            title: 'Đăng xuất',
            icon: Icons.logout,
            onTap: () {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  content: Text('Bạn có chắc chắn muốn đăng xuất không?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Không'),
                    ),
                    TextButton(
                      onPressed: () {
                        ZegoUIKitPrebuiltCallInvitationService().uninit();
                        Navigator.pop(context);
                        SocketManager().disconnectSocket();
                        SharedService.logout(context);
                      },
                      child: Text('Có'),
                    ),
                  ],
                );
              });
              //SharedService.logout(context);
              //Navigator.pushReplacementNamed(context, '/login');
            }),
      ],
    );
  }
}
