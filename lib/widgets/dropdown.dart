import 'package:flutter/material.dart';

const List<String> list = <String>[
  'Thanh toán qua VNPay',
  'Thanh toán qua ZaloPay'
];

class DropdownMenuExample extends StatefulWidget {
final double width;
final ValueNotifier<String?> valueNotifier;
const DropdownMenuExample({Key? key, required this.width, required this.valueNotifier}) : super(key: key);

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: list.first,
      width: widget.width,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
        widget.valueNotifier.value = value!;
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
