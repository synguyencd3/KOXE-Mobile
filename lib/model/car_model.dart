List<Car> carsFromJson(dynamic str) =>
    List<Car>.from((str).map((x) => Car.fromJson(x)));


class Car {
  late final String? id;
  late final String? name;
  late final String? description;
  late final List<String>? image;
  late final int? price;
  late final String? brand;
  late final String? origin;
  late final String? model;
  late final String? type;
  late final int? capacity;
  late final int? door;
  late final int? seat;
  late final int? kilometer;
  late final int? gear;
  
  Car({
    this.id,
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
    this.type
  });

  Car.fromJson(Map<String, dynamic> json) {
    id = json['car_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'].cast<String>();
    price = json['price'];
    type = json['type'];
  } 

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    data['type'] = this.type;
    return data; 
  }
}