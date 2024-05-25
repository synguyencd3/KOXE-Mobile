import 'package:flutter/material.dart';

const List<String> list = <String>[
  'Thanh toán qua VNPay',
  'Thanh toán qua ZaloPay'
];

class DropdownMenuExample extends StatefulWidget {
final ValueNotifier<String?> valueNotifier;
final List<String> items;
const DropdownMenuExample({Key? key, required this.valueNotifier,  required this.items, }) : super(key: key);

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  late String dropdownValue; // Thay đổi khai báo của dropdownValue

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.items.first; // Sử dụng giá trị đầu tiên từ danh sách được truyền vào
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: dropdownValue,
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
        widget.valueNotifier.value = value!;
      },
      dropdownMenuEntries: widget.items.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }

}
