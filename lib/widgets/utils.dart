import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage(ImageSource source) async {
  final ImagePicker _picker = ImagePicker();
  XFile? _file = await _picker.pickImage(source: source);
  if (_file != null) {
    return File(_file.path);
  }
  print('No image selected.');
  return null;
}