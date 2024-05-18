import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

Future<File?> pickImage(ImageSource source) async {
  final ImagePicker _picker = ImagePicker();
  XFile? _file = await _picker.pickImage(source: source);
  if (_file != null) {
    return File(_file.path);
  }
  print('No image selected.');
  return null;
}

String formatCurrency(int value) {
  final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
  return formatter.format(value);
}

