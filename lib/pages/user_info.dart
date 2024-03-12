import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/text_card.dart';
import 'package:mobile/services/api_service.dart';

class UserInfo extends StatefulWidget {


  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  Map<String,dynamic> userProfile={};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfile();
  }
  Future<void> getUserProfile() async {
    try {
      Map<String, dynamic> profile = await APIService.getUserProfile();
      print(profile);
      setState(() {
        userProfile = profile;
      });
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sửa hồ sơ'),
          backgroundColor: Colors.lightBlue,
        ),
        body: Column(children: [
          Container(
            width: double.infinity,
            color: Colors.grey[200],
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage( userProfile['avatar'] ?? ''),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Nhấp vào để thay ảnh đại diện',
                    style: TextStyle(),
                  ),
                  color: Colors.black12,
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                ),
              ],
            ),
          ),
          text_card(
              title: 'Họ và tên', trailingText: userProfile['fullname'] ?? 'Chưa cập nhật', onTap: () {

          }),
          text_card(
              title: 'Giới tính',
              trailingText: userProfile['gender'] == 1 ? 'Nam' : 'Nữ',
              onTap: () {
                print('Tap');
              }),
          text_card(
              title: 'Số điện thoại',
              trailingText: userProfile['phone'] ?? 'Chưa cập nhật',
              onTap: () {
                print('Tap');
              }),
          text_card(
              title: 'Địa chỉ',
              trailingText: userProfile['address'] ?? 'Chưa cập nhật',
              onTap: () {
                print('Tap');
              }),
          text_card(
              title: 'Ngày sinh',
              trailingText: '12-20-2002',
              onTap: () {
                print('Tap');
              }),
          text_card(
            title: 'Liên kết mạng xã hội',
            onTap: () {
              Navigator.pushNamed(context, 'social');
            },
          ),
          text_card(
            title: 'Đổi mật khẩu',
            onTap: () {},
          ),
        ]));
  }
}


