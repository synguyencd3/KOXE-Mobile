import 'package:flutter/material.dart';

import '../model/maintaince_model.dart';
class MaintainceCheckbox extends StatefulWidget {
  final MaintainceModel maintaince;
  late  ValueChanged<String?> onSelectedChanged;

  MaintainceCheckbox({required this.maintaince, required this.onSelectedChanged});

  @override
  _MaintainceCheckboxState createState() => _MaintainceCheckboxState();
}

class _MaintainceCheckboxState extends State<MaintainceCheckbox> {
  bool isChecked = false;


  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.maintaince.name),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
          if (isChecked) {
            widget.onSelectedChanged(widget.maintaince.id);
          } else {
            widget.onSelectedChanged(null);
          }
        });
      },
    );
  }
}