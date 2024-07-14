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
String formatDate(DateTime dateStr) {
  String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(dateStr);
  return formattedDate;
}

final List<String> carBrands = [
  'Toyota',
  'Honda',
  'Nissan',
  'Subaru',
  'Ford',
  'Chevrolet',
  'BMW',
  'Mercedes',
  'Audi',
  'Volkswagen',
  'Ferrari',
  'Aston Martin',
  'Saab',
  'Alfa Romeo',
  'Renault',
  'Lamborghini',
  'Khác'
];

final List<String> carTypes = [
  'Sedan',
  'SUV',
  'Crossover',
  'Coupe',
  'Convertible',
  'Hatchback',
  'Wagon',
  'Van',
  'Truck',
  'Minivan',
  'Crew Cab Pickup',
  'Extended Cab Pickup',
  'Regular Cab Pickup',
  'Cargo Van',
  'Passenger Van',
  'Compact',
  'Subcompact',
];
