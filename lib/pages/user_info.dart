import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/text_card.dart';


class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
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
                  backgroundImage: AssetImage('assets/1.png'),
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
              title: 'Họ và tên',
              trailingText: 'Nguyễn Văn A',
              onTap: () {
                print('Tap');
              }),
          text_card(
              title: 'Giới tính',
              trailingText: 'Nguyễn Văn A',
              onTap: () {
                print('Tap');
              }),
          text_card(
              title: 'Số điện thoại',
              trailingText: 'Nguyễn Văn A',
              onTap: () {
                print('Tap');
              }),
          text_card(
              title: 'Địa chỉ',
              trailingText: 'Nguyễn Văn A',
              onTap: () {
                print('Tap');
              }),
          text_card(
              title: 'Ngày sinh',
              trailingText: 'Nguyễn Văn A',
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
            onTap: () {

            },
          ),
        ]));
  }
}
