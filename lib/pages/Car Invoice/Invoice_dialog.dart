
import 'package:flutter/material.dart';
import 'package:mobile/model/document_model.dart';
import 'package:mobile/pages/loading.dart';
import 'package:mobile/services/process_service.dart';

import '../../model/CarInvoice_response.dart';
import '../../model/process_model.dart';

class InvoiceDialog extends StatefulWidget {
  late final CarInvoice model;

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

  List<Document> selectedProcesses = [];
   process? _process;

  void toggleObjectSelection(Document object) {
    setState(() {
     selectedProcesses.add(object);
    });
  }

  void getProcess() async {
    var data = await ProcessService.get(widget.model.legalsUser?.processId);
    if (data == null) return;
    setState(() {
      _process = data;
      for (var doc in _process!.documents!)
        {
          if (doc.period == widget.model.legalsUser?.currentPeriod) return;
          selectedProcesses.add(doc);
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
    String fullName = fullNameController.text;
    String phoneNumber = phoneNumberController.text;
   // String id = idController.text;
    String carName = carNameController.text;
    String emailAddress = emailAddressController.text;

    // Do something with the form inputs, such as sending them to an API

    Navigator.of(context).pop(); // Close the dialog
  }

  @override
  Widget build(BuildContext context) {
    return
      AlertDialog(
      title: Text('Information'),
      content: SingleChildScrollView(
        child: Column(
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
            // TextField(
            //   controller: idController,
            //   decoration: InputDecoration(labelText: 'ID'),
            // ),
            TextField(
              controller: carNameController,
              decoration: InputDecoration(labelText: 'Car Name'),
            ),
            TextField(
              controller: emailAddressController,
              decoration: InputDecoration(labelText: 'Email Address'),
            ),
            SizedBox(height: 16),
            Text('Select Objects:'),
            (_process == null ) ? Loading() :
                Column(
                  children: _process!.documents!.map((e)  {
                    return  CheckboxListTile(
                            title: Text(e.name!),
                            value: selectedProcesses.contains(e),
                            onChanged: (value) => toggleObjectSelection(e),
                            subtitle: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: e.details!.map((e) => Text(e.name!)).toList(),),
                            ));
                  }).toList()
                )
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

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Alert Dialog'),
//       ),
//       body: Center(
//         child: RaisedButton(
//           child: Text('Open Alert Dialog'),
//           onPressed: () {
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return MyAlertDialog();
//               },
//             );
//           },
//         ),
//       ),
//     ),
//   ));
// }