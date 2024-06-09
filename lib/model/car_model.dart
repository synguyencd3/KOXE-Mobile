import 'package:mobile/model/car_of_salon_model.dart';
import 'package:mobile/model/warranty_model.dart';
List<Car> carsFromJson(dynamic str) =>
    List<Car>.from((str).map((x) => Car.fromJson(x)));

class Car {
  String? id;
  String? name;
  String? description;
  List<String>? image;
  int? price;
  String? brand;
  String? origin;
  String? model;
  String? type;
  num? capacity;
  int? door;
  int? seat;
  int? kilometer;
  String? gear;
  String? mfg;
  String? outColor;
  CarSalon? salon;
  Warranty? warranty;

  Car(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.price,
      this.brand,
      this.capacity,
      this.door,
      this.gear,
      this.kilometer,
      this.model,
      this.origin,
      this.seat,
      this.type,
      this.mfg,
      this.outColor,
      this.salon});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['car_id'];
    name = json['name'];
    description = json['description'];
    json['image'] == null? image= ["null"]: image=json['image'].cast<String>();
    price = json['price'];
    type = json['type'];
    origin = json['origin'];
    model = json['model'];
    brand = json['brand'];
    capacity = json['capacity'];
    door = json['door'];
    seat = json['seat'];
    kilometer = json['kilometer'];
    gear = json['gear'];
    mfg = json['mfg'];
    outColor = json['outColor'];
    salon = json['salon'] != null ? CarSalon.fromJson(json['salon']): null;
    warranty = json['warranties'] != null ? Warranty.fromJson(json['warranties']): null;
  }

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['car_id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = "${this.price}";
    data['type'] = this.type;
    data['origin'] = this.origin;
    data['model'] = this.model;
    data['brand'] = this.brand;
    data['capacity'] = "${this.capacity}";
    data['door'] = "${this.door}";
    data['seat'] = "${this.seat}";
    data['kilometer'] = "${this.kilometer}";
    data['gear'] = this.gear;
    data['mfg'] = this.mfg;
    data['outColor'] = this.outColor;
    return data;
  }
}
