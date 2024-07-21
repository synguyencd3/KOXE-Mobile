

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile/model/document_model.dart';
import 'package:mobile/services/process_service.dart';

import '../../model/CarInvoice_response.dart';
import '../../model/process_model.dart';
import '../loading.dart';

class UserInvoiceDialog extends StatefulWidget {
  late final CarInvoice model;
  //final VoidCallback callMethod;

  UserInvoiceDialog({required this.model});

  @override
  _UserInvoiceDialogState createState() => _UserInvoiceDialogState();
}

class _UserInvoiceDialogState extends State<UserInvoiceDialog> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
 // TextEditingController idController = TextEditingController();
  TextEditingController carNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();

  Set<String> selectedProcesses = {};
  Set<String> selectedProcessInThisStage={};
   process? _process;
   Document? currentPeriod;
   int countSelected=0;
   int period=0;


  void getProcess() async {
    if (widget.model.legalsUser?.processId == null) return;
    var data = await ProcessService.get(widget.model.legalsUser?.processId, widget.model.seller?.salonId);
    setState(() {
      selectedProcessInThisStage = {};
      _process = data;
      for (var detail in widget.model.legalsUser!.details!)
      {
        selectedProcesses.add(detail);
      }
      for (var doc in _process!.documents!)
        {
          period++;
          if (doc.period == widget.model.legalsUser?.currentPeriod) {
            currentPeriod=doc;
            return;
          }
          //selectedProcesses.add(doc);
        }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullNameController.text=widget.model.fullname!;
    phoneNumberController.text=widget.model.phone!;
    carNameController.text=widget.model.carName!;
    emailAddressController.text= widget.model.email!;
    getProcess();
  }
  @override
  Widget build(BuildContext context) {
    return
      AlertDialog(
      title: Text('Thông tin'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              readOnly: true,
              controller: fullNameController,
              decoration: InputDecoration(labelText: 'Họ tên'),
            ),
            TextField(
              readOnly: true,
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Số điện thoại'),
            ),
            TextField(
              readOnly: true,
              controller: carNameController,
              decoration: InputDecoration(labelText: 'Tên xe'),
            ),
            TextField(
              readOnly: true,
              controller: emailAddressController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            (currentPeriod == null ) ? Loading() :
            Column(
              children: [
                Text(currentPeriod!.name!),
                Column(
                  children: currentPeriod!.details!.map((e) {
                    if (selectedProcesses.contains(e.name))
                      setState(() {
                        selectedProcessInThisStage.add(e.name!);
                      });
                    return   CheckboxListTile(
                            enabled: widget.model.done== null? false: !widget.model.done!,
                            value: selectedProcesses.contains(e.name),
                            title: Text(e.name!),
                            onChanged: (bool? value) {
                            });
                  }).toList(),
                )
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Thoát'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
