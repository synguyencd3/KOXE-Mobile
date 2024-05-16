

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile/model/document_model.dart';
import 'package:mobile/services/process_service.dart';

import '../../model/CarInvoice_response.dart';
import '../../model/process_model.dart';
import '../loading.dart';

class InvoiceDialog extends StatefulWidget {
  late final CarInvoice model;
  //final VoidCallback callMethod;

  InvoiceDialog({required this.model});

  @override
  _InvoiceDialogState createState() => _InvoiceDialogState();
}

class _InvoiceDialogState extends State<InvoiceDialog> {
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

  void toggleObjectSelection(String object) {
    if (selectedProcesses.contains(object))
      {
        setState(() {
          selectedProcesses.remove(object);
          selectedProcessInThisStage.remove(object);
        });
      }
    else {
    setState(() {
     selectedProcesses.add(object);
     selectedProcessInThisStage.add(object);
    });
    }
  }
  void countSelection(bool value)
  {
    if (value) {
      countSelected++;
    } else {
      countSelected--;
    }
  }

  void getProcess() async {
    if (widget.model.legalsUser?.processId == null) return;
    var data = await ProcessService.get(widget.model.legalsUser?.processId);
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
  void submitForm() {
   //  String fullName = fullNameController.text;
   //  String phoneNumber = phoneNumberController.text;
   // // String id = idController.text;
   //  String carName = carNameController.text;
   //  String emailAddress = emailAddressController.text;
   //
   //  // Do something with the form inputs, such as sending them to an API
    // Close the dialog
    ProcessService.updateDetails(widget.model.legalsUser!.carId!,widget.model.phone!, selectedProcesses.toList()).then((value)
    {
        if (value!) {
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tạo thành công'),
              backgroundColor: Colors.green,
            )
        );
        Navigator.pop(context);
      }
        else
        {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
        content: Text('Có lỗi xảy ra, vui lòng thử lại sau'),
        backgroundColor: Colors.red,
        )
        );
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      AlertDialog(
      title: Text('Information'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: carNameController,
              decoration: InputDecoration(labelText: 'Car Name'),
            ),
            TextField(
              controller: emailAddressController,
              decoration: InputDecoration(labelText: 'Email Address'),
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
                            value: selectedProcesses.contains(e.name),
                            title: Text(e.name!),
                            onChanged: (bool? value) {
                             toggleObjectSelection(e.name!);
                            });
                  }).toList(),
                )
              ],
            ),
            period == _process?.documents?.length ? TextButton(onPressed: () {
              ProcessService.updateDetails(widget.model.legalsUser!.carId!,widget.model.phone!, selectedProcesses.toList());
              ProcessService.done(widget.model.invoiceId!).then((value) {
                  if (value == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Tạo thành công'),
                          backgroundColor: Colors.green,
                        )
                    );
                    Navigator.pop(context);
                  }
                  else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Có lỗi xảy ra, vui lòng thử lại sau'),
                          backgroundColor: Colors.red,
                        )
                    );
                  }
                });
              Navigator.pop(context);
            },
            child: Text("Done")) :
            selectedProcessInThisStage.length ==  currentPeriod?.details?.length ?
                TextButton(onPressed: () {
                  ProcessService.updateDetails(widget.model.legalsUser!.carId!,widget.model.phone!, selectedProcesses.toList());
                  ProcessService.updateProcess(widget.model.legalsUser!.carId!,widget.model.phone!,_process!.documents![period].period!).then((value) {getProcess();}).then((value) {
                    if (value == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Tạo thành công'),
                            backgroundColor: Colors.green,
                          )
                      );
                      Navigator.pop(context);
                    }
                    else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Có lỗi xảy ra, vui lòng thử lại sau'),
                            backgroundColor: Colors.red,
                          )
                      );
                    }
                  });
                  Navigator.pop(context);
                },
                child: Text('next'),) : SizedBox(height: 10,)
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Submit'),
          onPressed: submitForm,
        ),
      ],
    );
  }
}
