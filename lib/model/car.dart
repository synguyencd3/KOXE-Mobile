List<Car> carsFromJson(dynamic str) =>
    List<Car>.from((str).map((x) => Car.fromJson(x)));


class Car {
  late final String? id;
  late final String? name;
  late final String? description;
  late final String? image;
  late final double? price;

  Car({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
  });

  Car.fromJson(Map<String, dynamic> json) {
    id = json['car_id'];
    name = json['name'];
    description = json['description'];
    image = 'assets/1.png';//json['image'];
    price = json['price'];
  } 

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    return data; 
  }
}