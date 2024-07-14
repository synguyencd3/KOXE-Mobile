import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/accessory_model.dart';

import '../services/accessory_service.dart';
import 'package:mobile/utils/utils.dart';

class AccessoryCard extends StatefulWidget {
  late AccessoryModel accessory;
   AccessoryCard({super.key, required this.accessory});

  @override
  State<AccessoryCard> createState() => _AccessoryCardState();
}

class _AccessoryCardState extends State<AccessoryCard> {
  bool isDeleted = false;
  Future<void> deleteAccessory() async {
    bool response = await AccessoryService().deleteAccessory(widget.accessory.id ?? '');
    if (response) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Xóa phụ tùng thành công'),
        backgroundColor: Colors.green,
      ));
      setState(() {
        isDeleted = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Xóa phụ tùng thất bại'),
        backgroundColor: Colors.red,
      ));
    }
  }
  Future<bool> updateAccessory(AccessoryModel accessory) async {
    bool response = await AccessoryService().updateAccessory(accessory);
    return response;
  }
  void showUpdateAccessoryDialog(BuildContext context) {
    final nameController = TextEditingController(text: widget.accessory.name);
    final manufacturerController = TextEditingController(text: widget.accessory.manufacturer);
    final priceController = TextEditingController(text: widget.accessory.price.toString());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cập nhật phụ tùng'),
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
              child: Text('Cập nhật'),
              onPressed: () async{
                // Handle OK button press
                AccessoryModel accessory = AccessoryModel(
                  id: widget.accessory.id,
                  name: nameController.text,
                  manufacturer: manufacturerController.text,
                  price: int.parse(priceController.text),
                );
                bool response = await updateAccessory(accessory);
                if (response) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Cập nhật phụ tùng thành công'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  setState(() {
                    widget.accessory = accessory;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Cập nhật phụ tùng thất bại'),
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
      child: Column(
        children: [
          ListTile(
            title: Text('Tên phụ kiện: ' + (widget.accessory.name ?? '') , style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nhà sản xuất: ' + (widget.accessory.manufacturer ?? ''), style: TextStyle(fontSize: 16),),
                Text('Giá: ' + '${formatCurrency(widget.accessory.price ?? 0) }', style: TextStyle(fontSize: 16),),
              ],
            ),

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // IconButton(onPressed: () {
              //
              // }, icon: Icon(Icons.info)),
              IconButton(onPressed: () {
                showUpdateAccessoryDialog(context);
              }, icon: Icon(Icons.edit)),
              IconButton(onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                            'Bạn có chắc chắn muốn xóa phụ tùng này không?'),
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
                              await deleteAccessory();
                            },
                            child: Text('Có'),
                          ),
                        ],
                      );
                    });
              }, icon: Icon(Icons.delete)),
            ],
          ),

        ],
      ),
    );
  }
}
