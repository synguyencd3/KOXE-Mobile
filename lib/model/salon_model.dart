import 'package:mobile/model/car_model.dart';
List<Salon> salonsFromJson(dynamic str) =>
    List<Salon>.from((str).map((x) => Salon.fromJson(x)));

class Salon {
  String? salonId;
  String? name;
  String? address;
  String? image;
  String? email;
  String? phoneNumber;
  List<String>? banner;
  String? introductionHtml;
  String? introductionMarkdown;
  String? userId;
  List<Car> cars = <Car>[];

  Salon(
      {this.salonId,
      this.name,
      this.address,
      this.image,
      this.email,
      this.phoneNumber,
      this.banner,
      this.introductionHtml,
      this.introductionMarkdown,
      this.userId,
      /*this.cars*/});

  Salon.fromJson(Map<String, dynamic> json) {
    salonId=json['salon_id'];
    userId = json['user_id'];
    json['name']==null? name='null':name = json['name'];
    json['address']==null? address="null":address = json['address'];
    json['image'] == null? image="null" :image = json['image'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    json['banner'] == null? banner=null:banner = json['banner'].cast<String>();
    introductionHtml = json['introductionHtml'];
    json['introductionMarkdown']==null? introductionMarkdown = "null" :introductionMarkdown = json['introductionMarkdown'];
    json['cars'] == null ? [] :cars = carsFromJson(json['cars']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salon_id'] = this.salonId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['image'] = this.image;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['banner'] = this.banner;
    data['introductionHtml'] = this.introductionHtml;
    data['introductionMarkdown'] = this.introductionMarkdown;
    //data['cars'] = this.cars;
    return data;
  }
}
