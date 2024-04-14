import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/services/salon_service.dart';

import '../../model/employee_model.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Employee> users = [];

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
      users =data;
      users.forEach((element) {print(element.permissions);});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Administration'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          return GestureDetector(
            child: ListTile(
              title: Text(user.fullname!),
              subtitle: Text("permission"),
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
                        children: [
                          Text(user.fullname!),
                          SizedBox(height: 16),
                          Text('Các quyền:'),
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
                                Text(entries.key),
                                StatefulBuilder(
                                  builder: (BuildContext context, StateSetter setState) {
                                    return CheckboxListTile(
                                      title: Text('Create'),
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
                                      title: Text('Read'),
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
                                      title: Text('Update'),
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
                                      title: Text('Delete'),
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
                        child: Text('Done'),
                        onPressed: () {
                          print(user.fullname);
                          print(user.permissions);
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

    );
  }
}
