List<AccessoryModel> accessoriesFromJson(dynamic str) =>
    List<AccessoryModel>.from(
        (str).where((x) => x != null).map((x) => AccessoryModel.fromJson(x)));
// create function accessoriesToJson
dynamic accessoriesToJson(List<AccessoryModel> data) =>
    List<dynamic>.from(data.map((x) => x.toJson()));

class AccessoryModel {
  String? id;
  final String? name;
  final String? manufacturer;
  final int? price;
  final int? quantity;

  AccessoryModel({
    this.id,
    this.name,
    this.manufacturer,
    this.price,
    this.quantity,
  });

  AccessoryModel.fromJson(Map<String, dynamic> json)
      : id = json.containsKey('accessory_id') ? json['accessory_id'] : null,
        name = json['name'],
        manufacturer =
            json.containsKey('manufacturer') ? json['manufacturer'] : null,
        quantity = json['quantity'],
        price = json['price'];

  Map<String, dynamic> toJson() => {
        'accessory_id': id,
        'name': name == null ? null : name,
        'manufacturer': manufacturer == null ? null : manufacturer,
        'price': price == null ? null : price,
        'quantity': quantity == null ? null : quantity,
      };
}
