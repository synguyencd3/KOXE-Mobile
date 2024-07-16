
class AccessoryRequestModel {
  final String id;
  final int quantity;

  AccessoryRequestModel({
    required this.id,
    required this.quantity,
  });

  Map<String, dynamic> toJson() =>
      {
        'accessory_id': id,
        'quantity': quantity,
      };
}