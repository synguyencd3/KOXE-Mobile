import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/salon_group_model.dart';
import 'package:mobile/services/salon_service.dart';

import '../../model/salon_model.dart';
import '../../services/salon_group_service.dart';
import 'package:mobile/pages/loading.dart';

class SalonGroup extends StatefulWidget {
  const SalonGroup({super.key});

  @override
  State<SalonGroup> createState() => _SalonGroupState();
}

class _SalonGroupState extends State<SalonGroup> {
  List<SalonGroupModel> salonGroups = [];
  List<Salon> salons = [];
  List<String> selectedSalonIds = [];
  TextEditingController groupNameController = TextEditingController();

  Future<void> getAllGroups() async {
    List<SalonGroupModel> salonGroupsAPI =
        await SalonGroupService.getAllGroups();
    salonGroups = salonGroupsAPI;
  }

  Future<void> getAllSalons() async {
    List<Salon> salonsAPI = await SalonsService.getSalonNoBlock();
    setState(() {
      salons = salonsAPI;
    });
  }

  Future<void> deleteGroup(String id) async {
    bool response = await SalonGroupService.deleteGroup(id);
    if (response) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Xóa nhóm thành công')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Xóa nhóm thất bại')));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getAllGroups();
      getAllSalons();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    groupNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Các nhóm salon'),
      ),
      body: Column(
        children: [
          TextButton.icon(
            icon: Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Tạo nhóm salon'),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextField(
                                controller: groupNameController,
                                decoration: InputDecoration(
                                  labelText: 'Tên nhóm',
                                ),
                              ),
                              Text('Chọn các salon',
                                  style: TextStyle(fontSize: 20)),
                              for (var salon in salons)
                                StatefulBuilder(builder:
                                    (BuildContext context, StateSetter setState) {
                                  return CheckboxListTile(
                                    title: Text(salon.name ?? ''),
                                    value:
                                        selectedSalonIds.contains(salon.salonId),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == true) {
                                          selectedSalonIds.add(salon.salonId!);
                                        } else {
                                          selectedSalonIds.remove(salon.salonId);
                                        }
                                        setState(() {});
                                      });
                                    },
                                  );
                                }),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Hủy')),
                          TextButton(
                              onPressed: () async {
                                SalonGroupModel group = SalonGroupModel(
                                    name: groupNameController.text,
                                    salonId: selectedSalonIds);
                                bool response =
                                    await SalonGroupService.createGroup(group);
                                if (response) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Tạo nhóm thành công')));
                                  setState(() {
                                    salonGroups.add(group);
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Tạo nhóm thất bại')));
                                }
                                Navigator.pop(context);
                              },
                              child: Text('Tạo')),
                        ],
                      );
                    });
              },
              label: Text('Tạo nhóm salon')),
          Expanded(
            child: FutureBuilder(
                future: getAllGroups(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Loading();
                  }
                  return salonGroups.isEmpty
                      ? Center(
                          child: Text('Không có group nào'),
                        )
                      : ListView.builder(
                          itemCount: salonGroups.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(salonGroups[index].name),
                                trailing: Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        TextButton(onPressed: (){
                                          groupNameController.text= salonGroups[index].name!;
                                          selectedSalonIds.clear();
                                          selectedSalonIds.addAll(salonGroups[index].salons!.map((e) => e.id).toList());
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text('Chỉnh sửa nhóm'),
                                                  content: SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        TextField(
                                                          controller: groupNameController,
                                                          decoration: InputDecoration(
                                                            labelText: 'Tên nhóm',
                                                          ),
                                                        ),
                                                        const SizedBox(height: 10,),
                                                        Text('Chọn các salon',
                                                            style: TextStyle(fontSize: 20)),
                                                        for (var salon in salons)
                                                          StatefulBuilder(builder:
                                                              (BuildContext context, StateSetter setState) {
                                                            return CheckboxListTile(
                                                              title: Text(salon.name ?? ''),
                                                              value:
                                                              selectedSalonIds.contains(salon.salonId),
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  if (value == true) {
                                                                    selectedSalonIds.add(salon.salonId!);
                                                                  } else {
                                                                    selectedSalonIds.remove(salon.salonId);
                                                                  }
                                                                  setState(() {});
                                                                });
                                                              },
                                                            );
                                                          }),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text('Hủy')),
                                                    TextButton(
                                                        onPressed: () async {
                                                          SalonGroupModel group = SalonGroupModel(
                                                            id: salonGroups[index].id,
                                                              name: groupNameController.text,
                                                              salonId: selectedSalonIds);
                                                          bool response =
                                                          await SalonGroupService.updateGroup(group);
                                                          if (response) {
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(
                                                                    content:
                                                                    Text('Chỉnh sửa thành công')));
                                                            setState(() {});
                                                          } else {
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(
                                                                    content: Text('Chỉnh sửa thất bại')));
                                                          }
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text('Sửa')),
                                                  ],
                                                );
                                              });
                                        }, child: Icon(Icons.edit)),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () async {
                                            showDialog(context: context, builder: (context) {
                                              return AlertDialog(
                                                title: Text('Xác nhận xóa'),
                                                content: Text('Bạn có chắc chắn muốn xóa nhóm này không?'),
                                                actions: [
                                                  TextButton(onPressed: () {
                                                    Navigator.pop(context);
                                                  }, child: Text('Hủy')),
                                                  TextButton(onPressed: () async {
                                                    await deleteGroup(salonGroups[index].id!);
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      salonGroups.removeAt(index);
                                                    });
                                                  }, child: Text('Xóa')),
                                                ],
                                              );
                                            });
                                          },
                                        ),
                                    
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Danh sách các salon'),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                for (var salon
                                                    in salonGroups[index].salons!)
                                                  ListTile(
                                                    title: Text(salon.name),
                                                  )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                              ),
                            );
                          },
                        );
                }),
          ),
        ],
      ),
    );
  }
}
