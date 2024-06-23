import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/model/authority_model.dart';
import 'package:mobile/services/authorities_service.dart';
import 'package:mobile/services/salon_service.dart';

import '../../model/employee_model.dart';
import '../loading.dart';

class Authorities extends StatefulWidget {
  @override
  _AuthoritiesState createState() => _AuthoritiesState();
}

class _AuthoritiesState extends State<Authorities> {
  List<authority> authorities = [];
  TextEditingController controller = TextEditingController();
  bool isCalling = false;

  void addEmployee(authority _authority) {
    setState(() {
      authorities.add(_authority);
    });
  }

  void assignPermissions(Employee user, String category, List<String> permissions) {
    setState(() {
      user.permissions = permissions;
    });
  }

  Future<void> removeAuthority(authority _authority) async {

    await AuthorityService.deleteRole(_authority.id!);
    await getAuthorities();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAuthorities();
  }

  Future<void> getAuthorities() async {
    var data = await AuthorityService.getRoles();
    setState(() {
      authorities = data;
      authorities.forEach((element) {print(element.permissions);});
      isCalling = true;
    });
  }

  void showAlertDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();
    List<String> permission = [];
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
                //Text(authority.name!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextField(controller: controller,),
                Text('Các quyền', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
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
                              value: permission.contains('C_${entries.value}'),
                              onChanged: (value) {
                                setState(() {
                                  if (value!) {
                                    permission.add('C_${entries.value}');
                                  } else {
                                    permission.remove('C_${entries.value}');
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
                              value:  permission.contains('R_${entries.value}'),
                              onChanged: (value) {
                                setState(() {
                                  if (value!) {
                                    permission.add('R_${entries.value}');
                                  } else {
                                    permission.remove('R_${entries.value}');
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
                              value:permission.contains('U_${entries.value}'),
                              onChanged: (value) {
                                setState(() {
                                  if (value!) {
                                    permission.add('U_${entries.value}');
                                  } else {
                                    permission.remove('U_${entries.value}');
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
                              value: permission.contains('D_${entries.value}'),
                              onChanged: (value) {
                                setState(() {
                                  if (value!) {
                                    permission.add('D_${entries.value}');
                                  } else {
                                    permission.remove('D_${entries.value}');
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
              onPressed: () async {
                print(controller.text);
                print(jsonEncode(permission));
                await AuthorityService.newRole(permission, controller.text);
                await getAuthorities();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý quyền'),
      ),
      body: authorities.isEmpty && !isCalling ? Loading() : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextButton.icon(
                icon: Icon(Icons.add),
                onPressed: () {
                  showAlertDialog(context);
                },
                label: Text(
                  'Thêm quyền mới',
                )),
            Expanded(
              child: ListView.builder(
                itemCount: authorities.length,
                itemBuilder: (context, index) {
                  final authority = authorities[index];
                  return GestureDetector(
                    child: ListTile(
                      title: Text(authority.name!),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => removeAuthority(authority),
                      ),
                    ),
                    onTap: () {
                      controller.text=authority.name!;
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
                                  //Text(authority.name!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  TextField(controller: controller,),
                                  Text('Các quyền', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 20),
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
                                                value: authority.permissions?.contains('C_${entries.value}'),
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value!) {
                                                      authority.permissions?.add('C_${entries.value}');
                                                    } else {
                                                      authority.permissions?.remove('C_${entries.value}');
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
                                                value:  authority.permissions?.contains('R_${entries.value}'),
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value!) {
                                                      authority.permissions?.add('R_${entries.value}');
                                                    } else {
                                                      authority.permissions?.remove('R_${entries.value}');
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
                                                value:authority.permissions?.contains('U_${entries.value}'),
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value!) {
                                                      authority.permissions?.add('U_${entries.value}');
                                                    } else {
                                                      authority.permissions?.remove('U_${entries.value}');
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
                                                value: authority.permissions?.contains('D_${entries.value}'),
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value!) {
                                                      authority.permissions?.add('D_${entries.value}');
                                                    } else {
                                                      authority.permissions?.remove('D_${entries.value}');
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
                                onPressed: () async {
                                  print(authority.name);
                                  print(jsonEncode(authority.permissions));
                                  await AuthorityService.setPermission(authority.permissions!, authority.id!, controller.text);
                                  await getAuthorities();
                                  Navigator.pop(context);
                                  },
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
          ],
        ),
      ),

    );
  }
}
