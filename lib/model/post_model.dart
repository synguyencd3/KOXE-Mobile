import 'dart:convert';

import 'package:mobile/model/user_post_model.dart';
import 'package:mobile/model/car_model.dart';

List<PostModel> postModelFromJson(dynamic str) =>
    List<PostModel>.from((str).map((x) => PostModel.fromJson(x)));

class PostModel {
  Car? car;
  List<String>? image;
  String? fuel;
  String? design;
  String? color;
  String? licensePlate;
  int? ownerNumber;
  String? accessory;
  String? registrationDeadline;
  String? address;
  String? postId;
  final String text;
  DateTime? createAt;
  UserPostModel? user;
  late String? salonId;

  PostModel({
    this.postId,
    required this.text,
    this.createAt,
    this.user,
    this.salonId,
    this.fuel,
    this.design,
    this.color,
    this.licensePlate,
    this.ownerNumber,
    this.accessory,
    this.registrationDeadline,
    this.address,
    this.image,
    this.car,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['post_id'],
      text: json['text'],
      createAt: DateTime.parse(json['createdAt']),
      user: UserPostModel.fromJson(json['postedBy']),
      fuel: json['fuel'],
      design: json['design'],
      color: json['color'],
      licensePlate: json['licensePlate'],
      ownerNumber: json['ownerNumber'],
      //accessory: json['accessory'],
      //registrationDeadline: json['registrationDeadline'],
      address: json['address'],
      image: json['image']!= null ? List<String>.from(json['image']): [],
      //car: Car.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() => {
        "text": text,
        "salons ": salonId,
        "brand": car?.brand,
        "type": car?.type,
        "mfg": car?.mfg,
        "version": car?.model,
        "gear": car?.gear,
        "fuel": fuel,
        "origin": car?.origin,
        "design": design,
        "seat": car?.seat,
        "color": color,
        "licensePlate": licensePlate,
        "ownerNumber": ownerNumber,
        "accessory": accessory,
        "registrationDeadline": registrationDeadline,
        "kilometer": car?.kilometer,
        "price": car?.price,
        "address": address,
        "image": image,
      };
}
