import 'package:flutter/material.dart';
import 'package:mobile/model/accessory_model.dart';

import '../model/maintaince_model.dart';
class AccessoryCheckbox extends StatefulWidget {
  final AccessoryModel accessory;
  late  ValueChanged<String?> onSelectedChanged;

  AccessoryCheckbox({required this.accessory, required this.onSelectedChanged});

  @override
  _AccessoryCheckboxState createState() => _AccessoryCheckboxState();
}

class _AccessoryCheckboxState extends State<AccessoryCheckbox> {
  bool isChecked = false;


  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.accessory.name ?? ''),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
          if (isChecked) {
            widget.onSelectedChanged(widget.accessory.id);
          } else {
            widget.onSelectedChanged(null);
          }
        });
      },
    );
  }
}