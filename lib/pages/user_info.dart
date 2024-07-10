import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:mobile/widgets/text_card.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/model/user_model.dart';
import 'package:intl/intl.dart';
import 'package:mobile/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/utils/utils.dart';
class UserInfo extends StatefulWidget {
  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  Map<String, dynamic> userProfile = {};
  File? _image;
  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    APIService.updateEmail("");
    controller = TextEditingController();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller.dispose();
    super.dispose();
  }

  Future<void> updateProfile(String prop) async {
    UserModel user = new UserModel();
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
    bool success = await APIService.updateUserProfile(user);
  }

  void selectImage() async {
    File? imgFile = await pickImage(ImageSource.gallery);
    if (imgFile != null) {
      UserModel user = new UserModel();
      user.avatarFile = imgFile; // Assign the File object directly
      bool success = await APIService.updateUserProfile(user);
      print(success);
      if (success) {
        setState(() {
          _image = imgFile;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    userProfile =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            {};
    print(userProfile);
    void submit(String prop) async {
      Navigator.of(context).pop(controller.text);
      await updateProfile(prop);
      setState(() {
        userProfile[prop] = controller.text;
      });
      controller.clear();
    }

    Future<String?> openDialog(String prop, String title) => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: userProfile[prop] ?? 'Chưa cập nhật',
                ),
                controller: controller,
                onSubmitted: (_) => submit(prop),
              ),
              actions: [
                TextButton(onPressed: () => submit(prop), child: Text('OK')),
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
          setState(() {
            userProfile[prop] = pickedDate.toIso8601String();
          });
          UserModel user = new UserModel();
          user.date_of_birth = pickedDate.toIso8601String();
          APIService.updateUserProfile(user);
        }
      });
    }

    Future<String?> openGenderDialog() {
      String? selectedGender = userProfile['gender'];
      return showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Giới tính'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <String>['Nam', 'Nữ', 'Khác'].map((String value) {
              return RadioListTile<String>(
                title: Text(value),
                value: value,
                groupValue: selectedGender,
                onChanged: (newValue) {
                  setState(() {
                    userProfile['gender'] = newValue;
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

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, 'update');
        return false; // Prevent the default back button behavior
      },
      child: Scaffold(
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
                    Stack(children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(_image!),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(userProfile[
                                          'avatar'] !=
                                      null
                                  ? userProfile['avatar']
                                  : 'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'),
                            ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                            onPressed: selectImage,
                            color: Colors.lightBlue,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              text_card(
                headingIcon: Icons.person,
                  title: 'Họ và tên',
                  trailingText: userProfile['fullname'] ?? 'Chưa cập nhật',
                  onTap: () {
                    openDialog('fullname', 'Họ và tên');
                  }),
              text_card(
                headingIcon: Icons.person,
                  title: 'Giới tính',
                  trailingText: userProfile['gender'] != null
                      ? userProfile['gender']
                      : 'Chưa cập nhật',
                  onTap: () {
                    openGenderDialog();
                  }),
              text_card(
                headingIcon: Icons.phone,
                  title: 'Số điện thoại',
                  trailingText: userProfile['phone'] ?? 'Chưa cập nhật',
                  onTap: () {
                    openDialog('phone', 'Số điện thoại');
                  }),
              text_card(
                  headingIcon: Icons.location_on,
                  title: 'Địa chỉ',
                  trailingText: userProfile['address'] ?? 'Chưa cập nhật',
                  onTap: () {
                    openDialog('address', 'Địa chỉ');
                  }),
              text_card(
                  headingIcon: Icons.calendar_today,
                  title: 'Ngày sinh',
                  trailingText: userProfile['date_of_birth'] != null
                      ? DateFormat('dd/MM/yyyy').format(DateTime.parse(
                          userProfile['date_of_birth'] as String))
                      : 'Chưa cập nhật',
                  onTap: () {
                    openDatePickerDialog('date_of_birth');
                  }),
              text_card(
                headingIcon: Icons.link,
                title: 'Liên kết mạng xã hội',
                onTap: () {
                  Navigator.pushNamed(context, '/social', arguments: {'profile': userProfile});
                },
              ),
              text_card(
                headingIcon: Icons.lock,
                title: 'Đổi mật khẩu',
                onTap: () {
                  Navigator.pushNamed(context, '/change_password');
                },
              ),
            ]),
          )),
    );
  }
}
