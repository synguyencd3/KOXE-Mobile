import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/pages/appointment.dart';
import 'package:mobile/widgets/bottom_bar.dart';
import 'package:mobile/widgets/introduction_car.dart';
import 'package:mobile/widgets/home.dart';
import 'package:mobile/model/page.dart';
import 'package:mobile/widgets/user.dart';
import 'package:mobile/pages/notification.dart';
import 'package:mobile/pages/chat/list_chat_users.dart';
import 'package:mobile/socket/socket_manager.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:badges/badges.dart' as badges;

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  List<PageModule> pages = [
    PageModule(page: Home(), label: 'Xin chào,'),
    PageModule(page: IntroCar(), label: 'Sản phẩm'),
    PageModule(page: Appointment(), label: 'Lịch hẹn'),
    PageModule(page: Message(), label: 'Tin nhắn'),
    PageModule(page: User(), label: 'Tài khoản'),
  ];
  int _currentIndex = 0;
  int _count = 0;
  StreamSubscription? _notificationSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSocket();
    _notificationSubscription = SocketManager.notificationStream.listen((data) {
      print(data);
      setState(() {
        _count++;
      });
    });
  }
  @override
  void dispose() {
    super.dispose();
    _notificationSubscription?.cancel();
  }
  Future<void> initSocket() async {
    final Map<String, dynamic> userProfile = await APIService.getUserProfile();
    String salonId = await SalonsService.isSalon();
    await SocketManager.initSocket(userProfile['user_id'], salonId, (data) {
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(pages[_currentIndex].label),
            GestureDetector(
              child: badges.Badge(
                badgeAnimation: badges.BadgeAnimation.fade(),
                  badgeContent: Text(_count.toString()), child: Icon(Icons.notifications, size: 30)),
              onTap: () {
                Navigator.pushNamed(context, '/notification');
                setState(() {
                  _count = 0;
                });
              },
            ),
          ],
        ),
        backgroundColor: Colors.lightBlue,
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
