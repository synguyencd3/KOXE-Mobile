import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/model/invoice_model.dart';
import 'package:mobile/services/maintaince_service.dart';
import 'package:mobile/model/maintaince_model.dart';
import 'package:mobile/pages/loading.dart';
import 'package:mobile/widgets/maintaince_card.dart';
import 'package:mobile/services/invoice_service.dart';
import '../../model/accessory_model.dart';
import '../../services/accessory_service.dart';

class MaintainceManage extends StatefulWidget {
  const MaintainceManage({super.key});

  @override
  State<MaintainceManage> createState() => _MaintainceManageState();
}

class _MaintainceManageState extends State<MaintainceManage>
    with SingleTickerProviderStateMixin {
  List<MaintainceModel> maintainces = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> getAllMaintainces() async {
    List<MaintainceModel> maintaincesAPI =
        await MaintainceService().getAllMaintainces();
    print(maintaincesAPI.length);
    maintainces = maintaincesAPI;
  }


  Future<bool> addMaintaincePackage(MaintainceModel maintaince) async {
    bool response = await MaintainceService().addMaintaincePackage(maintaince);
    return response;
  }


  void showAddMaintainceDialog(BuildContext context) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final costController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thêm gói bảo dưỡng'),
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
              child: Text('Thêm'),
              onPressed: () async {
                // Handle OK button press
                MaintainceModel maintaince = MaintainceModel(
                  name: nameController.text,
                  description: descriptionController.text,
                  cost: int.parse(costController.text),
                );

                bool response = await addMaintaincePackage(maintaince);
                if (response) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Thêm gói bảo dưỡng thành công'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  setState(() {
                    maintainces.add(maintaince);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Thêm gói bảo dưỡng thất bại'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý bảo dưỡng'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child:
                  FutureBuilder(
                      future: getAllMaintainces(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Loading();
                        }
                        return maintainces.isEmpty
                            ? Center(
                                child: TextButton(
                                    onPressed: () {
                                      showAddMaintainceDialog(context);
                                    },
                                    child: Text(
                                      'Thêm gói bảo dưỡng',
                                    )),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        showAddMaintainceDialog(context);
                                      },
                                      child: Text(
                                        'Thêm gói bảo dưỡng',
                                      )),
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: maintainces.length,
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.only(top: 1),
                                        itemBuilder: (context, index) {
                                          return MaintainceCard(
                                              maintaince: maintainces[index]);
                                        }),
                                  ),
                                ],
                              );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
