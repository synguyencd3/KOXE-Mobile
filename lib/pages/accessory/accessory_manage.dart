import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/model/accessory_model.dart';

import '../../services/accessory_service.dart';
import '../../widgets/accessory_card.dart';
import 'package:mobile/pages/loading.dart';

class AccessoriesManage extends StatefulWidget {
  const AccessoriesManage({super.key});

  @override
  State<AccessoriesManage> createState() => _AccessoriesManageState();
}

class _AccessoriesManageState extends State<AccessoriesManage> {
  late List<AccessoryModel> accessories = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> getAllAccessories() async {
    List<AccessoryModel> accessoriesAPI =
    await AccessoryService().getAccessoriesSalon();
    print(accessoriesAPI.length);
    accessories = accessoriesAPI;
  }

  Future<bool> addAccessory(AccessoryModel accessory) async {
    bool response = await AccessoryService().addAccessory(accessory);
    return response;
  }

  void showAddAccessoryDialog(BuildContext context) {
    final nameController = TextEditingController();
    final manufacturerController = TextEditingController();
    final priceController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thêm phụ tùng'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Tên phụ tùng',
                ),
              ),
              TextField(
                controller: manufacturerController,
                decoration: InputDecoration(
                  labelText: 'Nhà sản xuất',
                ),
              ),
              TextField(
                controller: priceController,
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
                AccessoryModel maintaince = AccessoryModel(
                  name: nameController.text,
                  manufacturer: manufacturerController.text,
                  price: int.parse(priceController.text),
                );

                bool response = await addAccessory(maintaince);
                if (response) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Thêm phụ tùng thành công'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  setState(() {
                    accessories.add(maintaince);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Thêm phụ tùng thất bại'),
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
        title: Text('Quản lý phụ tùng'),
        backgroundColor: Colors.lightBlue,
      ),
      body: FutureBuilder(
          future: getAllAccessories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Loading();
            }
            return accessories.isEmpty
                ? Center(
                child: TextButton.icon(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      showAddAccessoryDialog(context);
                    },
                    label: Text('Thêm phụ tùng')), 
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton.icon(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      showAddAccessoryDialog(context);
                    },
                    label: Text('Thêm phụ tùng')),
                Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.only(top: 1),
                      physics: BouncingScrollPhysics(),
                      itemCount: accessories.length,
                      itemBuilder: (context, index) {
                        return AccessoryCard(
                          accessory: accessories[index],
                        );
                      }),
                ),
              ],
            );
          }),
    );
  }
}
