import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/config.dart';
import 'package:mobile/pages/appointment/appointment.dart';
import 'package:mobile/pages/post/post.dart';
import 'package:mobile/services/shared_service.dart';
import 'package:mobile/widgets/bottom_bar.dart';
import 'package:mobile/widgets/introduction_car.dart';
import 'package:mobile/widgets/home.dart';
import 'package:mobile/model/page.dart';
import 'package:mobile/widgets/user.dart';
import 'package:mobile/pages/chat/list_chat_users.dart';
import 'package:mobile/socket/socket_manager.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:badges/badges.dart' as badges;
import 'package:mobile/services/notification_service.dart';
import 'package:mobile/model/notification_model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../model/chat_user_model.dart';
import '../services/chat_service.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  List<PageModule> pages = [
    PageModule(page: Home(), label: 'Xin chào'),
    PageModule(page: IntroCar(), label: 'Sản phẩm'),
    PageModule(page: Appointment(), label: 'Lịch hẹn'),
    PageModule(page: PostPage(), label: 'Bài viết'),
    PageModule(page: User(), label: 'Tài khoản'),
  ];
  int _currentIndex = 0;
  int _count = 0;
  int _countMessage = 0;
  StreamSubscription? _notificationSubscription;
  StreamSubscription? _messageSubscription;
  final List<NotificationModel> notifications = [];

  @override
  void initState() {
    super.initState();
    initSocket();
    initCallService();
    getAllNotification();
    getAllMessageNotSeen();
    _notificationSubscription =
        SocketManager().notificationStream.listen((data) {
      print(data);
      setState(() {
        _count++;
      });
    });
    _messageSubscription = SocketManager().messageStream.listen((data) {
      print(data);
      setState(() {
        _countMessage++;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _notificationSubscription?.cancel();
    _messageSubscription?.cancel();
  }

  void initCallService() async {
    var userLogin = await SharedService.loginDetails();
    print(userLogin?.user?.id);
    print(userLogin?.user?.username);
    print('initing');
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: Config.zegoAppID /*input your AppID*/,
      appSign: Config.zegoAppSign /*input your AppSign*/,
      userID:
          userLogin != null ? userLogin.user!.id!.substring(0, 8) : 'undefined',
      userName: userLogin != null ? userLogin.user!.fullname! : 'undefined',
      plugins: [ZegoUIKitSignalingPlugin()],
    );
  }

  Future<void> initSocket() async {
    final Map<String, dynamic> userProfile = await APIService.getUserProfile();
    String salonId = await SalonsService.isSalon();
    await SocketManager().initSocket(userProfile['user_id'], salonId, (data) {
      print(data);
    });
  }

  Future<void> getAllNotification() async {
    String salonId = await SalonsService.isSalon();
    int count = 0;
    List<NotificationModel> notificationAPI = [];
    if (salonId == '') {
      notificationAPI = await NotificationService.getAllNotification();
    } else {
      notificationAPI =
          await NotificationService.getAllNotificationSalon(salonId);
    }
    if (notificationAPI.isNotEmpty) {
      for (var item in notificationAPI) {
        if (item.isRead == false) {
          count++;
        }
      }
      setState(() {
        notifications.addAll(notificationAPI);
        _count = count;
      });
    }
  }

  Future<void> getAllMessageNotSeen() async {
    List<ChatUserModel> usersAPI = await ChatService.getAllChatedUsers();
    int _countTemp = 0;

    for (var item in usersAPI) {
      if (item.message?.status == false) {
        _countTemp++;
      }
    }
    setState(() {
      _countMessage = _countTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    double iconsSize = 30.0;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              pages[_currentIndex].label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  child: _count > 0
                      ? badges.Badge(
                          badgeAnimation: badges.BadgeAnimation.fade(),
                          badgeContent: Text(_count.toString()),
                          child: Icon(Icons.notifications_outlined, size: iconsSize, color: Colors.white,))
                      : Icon(Icons.notifications_outlined, size: iconsSize, color: Colors.white,),
                  onTap: () {
                    Navigator.pushNamed(context, '/notification',
                        arguments: notifications);
                    setState(() {
                      _count = 0;
                    });
                  },
                ),
              SizedBox(width: 10),
                GestureDetector(
                  child: _countMessage > 0
                      ? badges.Badge(
                      badgeAnimation: badges.BadgeAnimation.fade(),
                      badgeContent: Text(_countMessage.toString()),
                      child: Icon(Icons.chat_outlined, size: iconsSize, color: Colors.white,))
                      : Icon(Icons.chat_outlined, size: iconsSize, color: Colors.white,),
                  onTap: () {
                    Navigator.pushNamed(context, '/message');
                    setState(() {
                      _countMessage = 0;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.black87,
      ),
      body: pages[_currentIndex].page,
      bottomNavigationBar: BottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
