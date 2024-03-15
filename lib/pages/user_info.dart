import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/text_card.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/model/user_model.dart';
import 'package:intl/intl.dart';
class UserInfo extends StatefulWidget {
  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  Map<String, dynamic> userProfile = {};
  late TextEditingController controller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfile();
    controller = TextEditingController();

  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller.dispose();
    super.dispose();
  }

  Future<void> getUserProfile() async {

    try {
      Map<String, dynamic> profile = await APIService.getUserProfile();
      if (profile['date_of_birth'] != null) {
        DateTime dob = DateTime.parse(profile['date_of_birth']);
        profile['date_of_birth'] = DateFormat('dd-MM-yyyy').format(dob);
      }
      //print(profile);
      setState(() {
        userProfile = profile;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateProfile(String prop) async {
    UserModel user =  new UserModel();
    print(controller.text);
    switch (prop) {
      case 'fullname':
        user.fullname = controller.text;
        break;
      case 'gender':
        user.gender = controller.text;
        break;
      case 'phone':
        user.phone = controller.text;
        break;
      case 'address':
        user.address = controller.text;
        break;
      default:
        break;
    }
    print(user.toJson());

     bool success = await APIService.updateUserProfile(user);
     print(success);

  }

  @override
  Widget build(BuildContext context) {
    void submit(String prop)  async {
      Navigator.of(context).pop(controller.text);
      await updateProfile(prop);
      setState(() {
        userProfile[prop] = controller.text;
      });
      controller.clear();
    }

    Future<String?> openDialog(String prop) => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(prop),
              content: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: userProfile[prop] ?? 'Chưa cập nhật',
                ),
                controller: controller,
                onSubmitted: (_) => submit(prop),
              ),
              actions: [
                TextButton(onPressed: ()=>submit(prop), child: Text('OK')),
              ],
            ));
    Future<DateTime?> openDatePickerDialog(String prop) {
      return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          setState(() {
            userProfile[prop] = formattedDate;
          });
          UserModel user =  new UserModel();
          user.date_of_birth = formattedDate;
          APIService.updateUserProfile(user);
        }
      });
    }
    Future<String?> openGenderDialog(String prop) {
      String? selectedGender = userProfile[prop];
      return showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(prop),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <String>['Nam', 'Nữ', 'Khác'].map((String value) {
              return RadioListTile<String>(
                title: Text(value),
                value: value,
                groupValue: selectedGender,
                onChanged: (newValue) {
                  setState(() {
                    userProfile[prop] = newValue;
                    selectedGender = newValue;
                  });
                  UserModel user = new UserModel();
                  user.gender = newValue;
                  APIService.updateUserProfile(user);
                  Navigator.of(context).pop(newValue);
                },
              );
            }).toList(),
          ),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Sửa hồ sơ'),
          backgroundColor: Colors.lightBlue,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              width: double.infinity,
              color: Colors.grey[200],
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(userProfile['avatar'] != null
                        ? userProfile['avatar']
                        : 'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'),
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
                trailingText: userProfile['fullname'] ?? 'Chưa cập nhật',
                onTap: () {
                  openDialog('fullname');
                }),
            text_card(
                title: 'Giới tính',
                trailingText: userProfile['gender'] != null
                    ? userProfile['gender']
                    : 'Chưa cập nhật',
                onTap: () {
              openGenderDialog('gender');
                }),
            text_card(
                title: 'Số điện thoại',
                trailingText: userProfile['phone'] ?? 'Chưa cập nhật',
                onTap: () {
               openDialog('phone');
                }),
            text_card(
                title: 'Địa chỉ',
                trailingText: userProfile['address'] ?? 'Chưa cập nhật',
                onTap: () {
                openDialog('address');
                }),
            text_card(
                title: 'Ngày sinh',
                trailingText: userProfile['date_of_birth'] ?? 'Chưa cập nhật',
                onTap: () {
                  openDatePickerDialog('date_of_birth');
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
          ]),
        ));
  }
}
