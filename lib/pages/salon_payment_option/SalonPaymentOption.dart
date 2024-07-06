import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/Payment_Method_Request.dart';
import '../../model/Payment_Method_Response.dart';
import '../../services/salon_service.dart';
import '../loading.dart';

class SalonPaymentMethod extends StatefulWidget {
  @override
  _NewObjectListPageState createState() => _NewObjectListPageState();
}

class _NewObjectListPageState extends State<SalonPaymentMethod> {
  List<PaymentMethod> objects = [];
  bool isLoading = false;
  Set<String> _permission = {};

  @override
  void initState() {
    super.initState();
    getPermission();
    _fetch();
  }

  void getPermission() async {
    var data = await SalonsService.getPermission();
    setState(() {
      _permission = data;
    });
  }

  void _createNewMethod(String type, String content, String fullname) async {
    await SalonsService.createPaymentMethod(PaymentMethodRequest(
      type: type,
      content: content,
      fullname: fullname,
    ));
    _fetch();
  }

  void _updateNewMethod(String id,String type, String content, String fullname) async {
    await SalonsService.updatePaymentMethod(PaymentMethod(
      id: id,
      type: type,
      content: content,
      fullname: fullname,
    ));
    _fetch();
  }

void _fetch() async {
    setState(() {
      isLoading= true;
    });
    var data = await SalonsService.getPaymentMethods();
    setState(() {
      objects = data;
      isLoading = false;
    });
}

  void _showForm(PaymentMethod? method) {
    final _formKey = GlobalKey<FormState>();
    String id = method?.id ?? '';
    String type = method?.type ??'';
    String content = method?.content ?? '';
    String fullname = method?.fullname ?? '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: type,
                    decoration: InputDecoration(labelText: 'Tên phương thức'),
                    onChanged: (value) => type = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: content,
                    decoration: InputDecoration(labelText: 'Nôi dung'),
                    onChanged: (value) => content = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: fullname,
                    decoration: InputDecoration(labelText: 'Họ tên tài khoản'),
                    onChanged: (value) => fullname = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  method == null ?
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _createNewMethod( type, content, fullname);
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Thêm'),
                  ):
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _updateNewMethod(id, type, content, fullname);
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Sửa'),
                  )

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void alert(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận'),
          content: Text('Bạn muốn xóa sản phẩm này?'),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text('Xóa'),
              onPressed: () async {
                Navigator.of(context).pop();
                await SalonsService.deletePaymentMethod(id).then((value) => _fetch());
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
        title: Text('Phương thức thanh toán'),
      ),
      body: Column(
        children: [
          _permission.contains("OWNER") || _permission.contains("C_PMT")
              ? TextButton.icon(
              onPressed: () {
                _showForm(null);
              },
              icon: Icon(Icons.add),
              label: Text('Thêm phương thức thanh toán'))
              : Container(),
          isLoading ? Loading() :
          Expanded(
            child: ListView.builder(
              itemCount: objects.length,
              itemBuilder: (context, index) {
               var obj = objects[index];
                return Card(
                  child: ListTile(
                    title: Text(obj.fullname ?? 'No Name'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phương thức: ${obj.type ?? 'No Type'}'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tài khoản: ${obj.content ?? 'No Content'}'),
                            Row(
                              children: [
                                _permission.contains("OWNER") || _permission.contains("D_PMT") ?
                                IconButton(onPressed: (){ alert(obj.id?? "");}, icon: Icon(Icons.delete)): Container(),
                                _permission.contains("OWNER") || _permission.contains("U_PMT") ?
                                IconButton(onPressed: (){  _showForm(obj); }, icon: Icon(Icons.edit)): Container()
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

