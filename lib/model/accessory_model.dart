List<AccessoryModel> accessoriesFromJson(dynamic str) =>
    List<AccessoryModel>.from((str).map((x) => AccessoryModel.fromJson(x)));

class AccessoryModel {
   String? id;
final String name;
final String manufacturer;
final int price;

  AccessoryModel({
     this.id,
    required this.name,
    required this.manufacturer,
    required this.price,
  });

  AccessoryModel.fromJson(Map<String, dynamic> json)
      : id = json['accessory_id'],
        name = json['name'],
        manufacturer = json['manufacturer'],
        price = json['price'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'manufacturer': manufacturer,
        'price': price,
  };
}
