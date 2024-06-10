import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/services/salon_service.dart';

import '../../model/employee_model.dart';
import '../loading.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Employee> users = [];
  bool isCalling = false;

  void addEmployee(Employee user) {
    setState(() {
      users.add(user);
    });
  }

  void assignPermissions(Employee user, String category, List<String> permissions) {
    setState(() {
      user.permissions = permissions;
    });
  }

  void removeEmployee(Employee user) {
    setState(() {
      users.remove(user);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmployees();
  }

  Future<void> getEmployees() async {
    var data = await SalonsService.getEmployees();
    setState(() {
      users =data.where((element) => element.permissions!.contains("OWNER")==false).toList();
      users.forEach((element) {print(element.permissions);});
      isCalling = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý nhân viên'),
      ),
      body: users.isEmpty && !isCalling ? Loading() : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return GestureDetector(
              child: ListTile(
                title: Text(user.fullname!),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => removeEmployee(user),
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                     return AlertDialog(
                      title: Text('Phân quyền '),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.fullname!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            Text('Các quyền', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            for (MapEntry<String, String> entries in {
                              'Nhân viên': 'EMP',
                              'Salon': 'SL',
                              'Xe': 'CAR',
                              'Lịch hẹn': 'APM',
                              'Bảo hành': 'WRT',
                              'Bảo dưỡng': 'MT',
                              'Thông báo': 'NTF'
                            }.entries)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(entries.key, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) {
                                      return CheckboxListTile(
                                        title: Text('Cho phép tạo'),
                                        value: user.permissions?.contains('C_${entries.value}'),
                                         onChanged: (value) {
                                          setState(() {
                                            if (value!) {
                                              user.permissions?.add('C_${entries.value}');
                                            } else {
                                              user.permissions?.remove('C_${entries.value}');
                                            }
                                          });
                                        },
                                      );
                                    }
                                  ),
                                  StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) {
                                      return CheckboxListTile(
                                        title: Text('Cho phép đọc'),
                                         value:  user.permissions?.contains('R_${entries.value}'),
                                        onChanged: (value) {
                                          setState(() {
                                            if (value!) {
                                              user.permissions?.add('R_${entries.value}');
                                            } else {
                                              user.permissions?.remove('R_${entries.value}');
                                            }
                                          });
                                         },
                                      );
                                    }
                                  ),
                                  StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) {
                                      return CheckboxListTile(
                                        title: Text('Cho phép cập nhật'),
                                         value:user.permissions?.contains('U_${entries.value}'),
                                        onChanged: (value) {
                                          setState(() {
                                            if (value!) {
                                              user.permissions?.add('U_${entries.value}');
                                            } else {
                                              user.permissions?.remove('U_${entries.value}');
                                            }
                                          });
                                        },
                                      );
                                    }
                                  ),
                                  StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) {
                                      return CheckboxListTile(
                                        title: Text('Cho phép xóa'),
                                        value: user.permissions?.contains('D_${entries.value}'),
                                        onChanged: (value) {
                                          setState(() {
                                            if (value!) {
                                              user.permissions?.add('D_${entries.value}');
                                            } else {
                                              user.permissions?.remove('D_${entries.value}');
                                            }
                                          });
                                        },
                                      );
                                    }
                                  ),
                                  SizedBox(height: 16),
                                ],
                              ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: Text('Hủy'),
                          onPressed: () {
                            Navigator.pop(context);},
                        ), TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            print(user.fullname);
                            print(jsonEncode(user.permissions));
                            SalonsService.setPermission(user.permissions!, user.userId!);
                            Navigator.pop(context);},
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),

    );
  }
}
