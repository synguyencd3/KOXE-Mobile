import 'package:mobile/model/car_model.dart';
List<SalonGroup> salonsFromJson(dynamic str) =>
    List<SalonGroup>.from((str).map((x) => SalonGroup.fromJson(x)));

class SalonGroup {
  String id;
  String name;

  SalonGroup(
      {required this.id, required this.name});

  factory SalonGroup.fromJson(Map<String, dynamic> json) {
    return SalonGroup(
      id: json['id'],
      name: json['name'],
    );
  }
}
