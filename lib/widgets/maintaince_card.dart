import 'package:flutter/material.dart';
import 'package:mobile/model/maintaince_model.dart';
import '../services/maintaince_service.dart';
import 'package:mobile/services/salon_service.dart';

class MaintainceCard extends StatefulWidget {
  late MaintainceModel maintaince;

   MaintainceCard({super.key, required this.maintaince });

  @override
  State<MaintainceCard> createState() => _MaintainceCardState();
}

class _MaintainceCardState extends State<MaintainceCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getPermission();
    });
  }
  bool isDeleted = false;
  Set<String> permission = {};
  void getPermission() async {
    var data = await SalonsService.getPermission();
    setState(() {
      permission = data;
    });
  }
  Future<void> deleteMaintaince() async {
    bool response =
        await MaintainceService().deleteMaintaincePackage(widget.maintaince.id ?? '');
    if (response) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Xóa gói bảo dưỡng thành công'),
        backgroundColor: Colors.green,
      ));
      setState(() {
        isDeleted = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Xóa gói bảo dưỡng thất bại'),
        backgroundColor: Colors.red,
      ));

    }
  }
  Future<bool> updateMaintaince(MaintainceModel maintaince) async {
    bool response = await MaintainceService().updateMaintaincePackage(maintaince);
    return response;
  }
  void showAddMaintainceDialog(BuildContext context) {
    final nameController = TextEditingController(text: widget.maintaince.name);
    final descriptionController = TextEditingController(text: widget.maintaince.description);
    final costController = TextEditingController(text: widget.maintaince.cost.toString());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cập nhật gói bảo dưỡng'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Tên gói',
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Mô tả gói',
                ),
              ),
              TextField(
                controller: costController,
                decoration: InputDecoration(
                  labelText: 'Giá tiền',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cập nhật'),
              onPressed: () async{
                // Handle OK button press
                MaintainceModel maintaince = MaintainceModel(
                  id: widget.maintaince.id,
                  name: nameController.text,
                  description: descriptionController.text,
                  cost: int.parse(costController.text),
                );
                bool response = await updateMaintaince(maintaince);
                if (response) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Cập nhật gói bảo dưỡng thành công'),
                      backgroundColor: Colors.green,
                    ),
                  );
                setState(() {
                  widget.maintaince = maintaince;
                });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Cập nhật gói bảo dưỡng thất bại'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    if (isDeleted) {
      return SizedBox.shrink();
    }
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              'Gói bảo dưỡng: ${widget.maintaince.name}',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text('Giá: ${widget.maintaince.cost}'),
            leading: Icon(Icons.money),
          ),
          ListTile(
            title: Text('Mô tả: ${widget.maintaince.description}'),
            leading: Icon(Icons.description),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              permission.contains("OWNER") || permission.contains("U_MT") ?
              IconButton(onPressed: () {
                showAddMaintainceDialog(context);
              }, icon: Icon(Icons.edit)): SizedBox.shrink(),
              permission.contains("OWNER") || permission.contains("D_MT") ?
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(
                                'Bạn có chắc chắn muốn xóa gói bảo dưỡng này không?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Không'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await deleteMaintaince();
                                },
                                child: Text('Có'),
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(Icons.delete)): SizedBox.shrink(),
            ],
          ),
        ],
      ),
    ));
  }
}
