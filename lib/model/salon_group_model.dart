

import 'package:mobile/model/salon_group.dart';

List<SalonGroupModel> salonGroupFromJson(dynamic str) =>
    List<SalonGroupModel>.from((str).map((x) => SalonGroupModel.fromJson(x)));

class SalonGroupModel {
  String? id;
  String name;
List<SalonGroup>? salons;
List<String>? salonId = [];

  SalonGroupModel(
      { this.id, required this.name, this.salons, this.salonId});

  factory SalonGroupModel.fromJson(Map<String, dynamic> json) {
    return SalonGroupModel(
      id: json['id'],
      name: json['name'],
      salons: List<SalonGroup>.from(json['salons'].map((x) => SalonGroup.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'salons': salonId,
      };
}
